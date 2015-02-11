require 'rss'
require 'open-uri'
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
    open('http://www.rubyflow.com/rss') { |rss| RSS::Parser.parse(rss) }
  end
end