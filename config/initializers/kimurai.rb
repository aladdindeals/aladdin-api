Kimurai.configure do |config|
  # Default logger has colored mode in development.
  # If you would like to disable it, set `colorize_logger` to false.
  # config.colorize_logger = false

  # Logger level for default logger:
  config.log_level = :debug

  # Custom logger:
  # config.logger = Logger.new(STDOUT)

  # Custom time zone (for logs):
  # config.time_zone = "UTC"
  # config.time_zone = "Europe/Moscow"

  # Provide custom chrome binary path (default is any available chrome/chromium in the PATH):
  config.selenium_chrome_path = "/usr/bin/chromium-browser"
  config.chromedriver_path    = "/usr/bin/chromedriver"
  config.selenium_firefox_path = "/usr/bin/firefox"
  config.geckodriver_path    = "/usr/bin/firefox.geckodriver"
end