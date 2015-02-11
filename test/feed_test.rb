ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'minitest/autorun'
require_relative '../app.rb'

class RubyFlowRSSFeedTest < Minitest::Test
  include Rack::Test::Methods

  def app
    RubyFlowRSSFeed
  end

  def test_feed_ok
    get '/'
    assert last_response.ok?
    assert_match 'Ruby Flow RSS', last_response.body
  end
end