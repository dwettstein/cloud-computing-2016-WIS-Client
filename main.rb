load 'config/sinatra.rb'

before do
  @pages = %w"ip locations connections stationboard weather stations weathers future_weathers"
  @author = 'Reto Schiegg, David Wettstein'
  @year = 2016
  # Define the URL of the Heroku App. Will be used within the templates.
  @heroku_api = "https://leave-the-cloud-saas-app.herokuapp.com" # No backslash at end.
end

# Added home route.
get '/' do
  @page = 'index'
  slim :index
end

get '/ip' do
  @page = 'ip'
  slim :index
end

get '/locations' do
  @page = 'locations'
  slim :index
end

get '/connections' do
  @page = 'connections'
  slim :index
end

get '/stationboard' do
  @page = 'stationboard'
  slim :index
end

get '/weather' do
  @page = 'weather'
  slim :index
end

get '/stations' do
  @page = 'stations'
  slim :index
end

get '/weathers' do
  @page = 'weathers'
  slim :index
end

get '/future_weathers' do
  @page = 'future_weathers'
  slim :index
end

def get_browser_ip()
  if @client_ip == nil
    @client_ip = request.ip # IP also in @env['REMOTE_ADDR']
  end
  return @client_ip
end
