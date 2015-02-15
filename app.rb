require 'rss'
require 'net/http'
require 'sinatra/base'
require 'sinatra/reloader' if ENV['RACK_ENV'] == 'development'

class RubyFlowRSSFeed < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    @feed = fetch_rss_feed
    erb :feed
  end

  private

  def fetch_rss_feed
    uri = URI('http://www.rubyflow.com/rss')
    req = Net::HTTP::Get.new(uri)

    res = Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(req) }

    RSS::Parser.parse(res.body)
  end
end