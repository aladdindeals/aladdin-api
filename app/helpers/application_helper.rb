module ApplicationHelper
  def flash_bg_class(status)
    case status.to_sym
    when :error
      'bg-red-100 text-red-700'
    when :success
      'bg-green-100 text-green-700'
    when :warning
      'bg-yellow-100 text-yellow-700'
    else
      'bg-blue-100 text-blue-700'
    end
  end
end
