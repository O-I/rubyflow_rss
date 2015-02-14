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
    RSS::Parser.parse(Net::HTTP.get(URI('http://www.rubyflow.com/rss')))
  end
end