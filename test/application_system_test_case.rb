require 'test_helper'

# Rails 5.2 doesn't let driven_by customize headless_chrome's Options
# (Browser#options always builds a fresh one with just --headless).
# Chrome refuses to start as root without --no-sandbox, which is how
# CI/Docker run this suite, so patch the private builder instead.
module ActionDispatch
  module SystemTesting
    class Browser
      private

      def headless_chrome_browser_options
        options = Selenium::WebDriver::Chrome::Options.new
        options.args << '--headless'
        options.args << '--no-sandbox'
        options.args << '--disable-dev-shm-usage'
        options.args << '--disable-gpu'
        options
      end
    end
  end
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
end
