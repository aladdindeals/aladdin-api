class Scrapper::DataItem
  attr_accessor :raw_data, :configuration

  def initialize(raw_data, configuration)
    @raw_data      = raw_data
    @configuration = OpenStruct.new(configuration)
  end

  def parse
    remove_spaces!
    data = convert_using_pattern
    case configuration.type
    when 'float'
      data.to_f
    when 'integer', 'int'
      data.to_i
    when 'date'
      begin
        Date.parse(data.to_s)
      rescue
        data
      end
    else
      data.to_s
    end
  end

  private

  def convert_using_pattern
    return raw_data if configuration.pattern.blank?
    binding.pry if configuration.database_field == 'price'
    if configuration.pattern_key.present? && configuration.ruby_regex_method.present?
      convert_to = configuration.regex_convert_to.present? ? configuration.regex_convert_to : 'to_s'
      data       = raw_data
                     .send(configuration.ruby_regex_method, configuration.pattern)
                     .send(convert_to)
      return data unless convert_to == 'hash'
      data&.transform_keys { |k| k.downcase }&.dig(configuration.pattern_key.to_s)
    else
      raw_data.match(configuration.pattern).to_s
    end
  end

  def remove_spaces!
    return unless configuration.type.to_s.in?(['float', 'int', 'integer'])
    @raw_data = raw_data.to_s.gsub(/[, ]/, '')
  end

end