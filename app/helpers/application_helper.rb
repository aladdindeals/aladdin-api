module ApplicationHelper
  INDIAN_COMMA_REGEX = /(\d+?)(?=(\d\d)+(\d)(?!\d))(\.\d+)?/

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

  def comma_style(num, rounding: 1, precision: 2)
    return ('-&nbsp;&nbsp;&nbsp;'.html_safe) if num.zero?
    rounded_num = (num.to_f / rounding)
    number_with_precision(rounded_num.abs, precision: precision, delimiter: ',', delimiter_pattern: INDIAN_COMMA_REGEX)
  end

  def top_nav_header_links
    [
      {
        name:            'Home',
        path:            root_path,
        class:           'flex justify-between py-2 text-base font-medium text-dark hover:text-primary lg:mx-5 lg:inline-flex lg:py-6 2xl:mx-6',
        drop_down_links: []
      },
      {
        name:            'Shop',
        path:            root_path,
        class:           'flex justify-between py-2 text-base font-medium text-dark hover:text-primary lg:mx-5 lg:inline-flex lg:py-6 2xl:mx-6',
        drop_down_links: []
      },
      {
        name:            'Accessories',
        path:            root_path,
        class:           'flex justify-between py-2 text-base font-medium text-dark hover:text-primary lg:mx-5 lg:inline-flex lg:py-6 2xl:mx-6',
        drop_down_links: []
      },
      {
        name:            'Contact',
        path:            root_path,
        class:           'flex justify-between py-2 text-base font-medium text-dark hover:text-primary lg:mx-5 lg:inline-flex lg:py-6 2xl:mx-6',
        drop_down_links: []
      }
    ]
  end
end
