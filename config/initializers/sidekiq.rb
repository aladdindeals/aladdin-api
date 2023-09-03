if Rails.env.development?
  Rails.logger.level        = Logger::DEBUG
  ActiveRecord::Base.logger = Logger.new STDOUT
end

Sidekiq.configure_server do |config|
  if Rails.env.development?
    config.redis = { url: ENV.fetch('REDIS_URL') { 'redis://127.0.0.1:6379/6' } }
  else
    config.redis = { url: ENV["REDIS_URL"] }
  end
end

Sidekiq.configure_client do |config|
  if Rails.env.development?
    config.redis = { url: ENV.fetch('REDIS_URL') { 'redis://127.0.0.1:6379/6' } }
  else
    config.redis = { url: ENV["REDIS_URL"] }
  end
end
