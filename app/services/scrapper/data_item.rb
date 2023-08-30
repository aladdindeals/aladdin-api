class Scrapper::DataItem
  attr_accessor :raw_data, :configuration
  REGEX_METHODS = {
    "amount":       [/(\d+(?:,\d+)*(?:\.\d+)?)/],
    "whole_number": [/\d+$/],
    "percentage":   [/(\d+(?:\.\d+)?)/]
  }

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
    when 'array'
      [data].flatten
    else
      data.to_s
    end
  end

  private

  def convert_using_pattern
    return raw_data.scan(Regexp.new(configuration.pattern))&.flatten&.join('').to_s if configuration.pattern.present?
    regex_patterns = REGEX_METHODS[configuration.pattern_method&.to_sym]
    return raw_data if regex_patterns.blank?
    regex_patterns.map do |regex|
      raw_data.match(regex).to_s
    end.compact_blank.first
  end

  def remove_spaces!
    return unless configuration.type.to_s.in?(['float', 'int', 'integer'])
    @raw_data = raw_data.to_s.gsub(/[, ]/, '')
  end

end