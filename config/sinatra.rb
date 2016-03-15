require 'sinatra'
require 'sinatra/reloader' if development?
require 'better_errors' if development?
require 'slim'
require 'coffee-script'
require 'tilt/coffee'
require 'sass'

load 'config/slim_helpers.rb'

include SlimHelpers

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

set :show_exceptions, :after_handler
set :views, settings.root + '/templates'

get '/js/*.js' do
  coffee "../assets/coffee/#{params[:splat].first}".to_sym
end

get '/css/*.css' do
  sass "../assets/stylesheets/#{params[:splat].first}".to_sym
end

not_found do
  body 'Ooops, this page does not exist :('
end

error do
  body 'Ooops, something went wrong :('
end
