module ProductUrlsHelper
  def status_tag(status)
    case status
    when 'pending'
      'bg-yellow-100 text-yellow-700'
    when 'processing'
      'bg-blue-100 text-blue-700'
    when 'success'
      'bg-green-100 text-green-700'
    else
      'bg-red-100 text-red-700'
    end
  end
end
