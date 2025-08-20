require "simplecov"
SimpleCov.start "rails" do
  add_filter "/bin/"
  add_filter "/db/"
  add_filter "/test/"
  add_filter "app/controllers/pages_controller.rb"       # ไม่ต้องนับไฟล์เดียว
  add_filter "app/jobs/"                                 # ไม่ต้องนับทั้งโฟลเดอร์
  add_filter "app/mailers/"                              # ไม่ต้องนับทั้งโฟลเดอร์
  end


ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
