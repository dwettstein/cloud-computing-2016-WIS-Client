load 'config/sinatra.rb'

before do
  @pages = %w"home ip locations connections stationboard weather stations weathers future_weathers"
  @author = 'Reto Schiegg, David Wettstein'
  @year = 2016
  # Define the URL of the Heroku App. Will be used within the templates.
  @heroku_api = "https://leave-the-cloud-saas-app.herokuapp.com" # No backslash at end.
  #@heroku_api = "http://localhost:4000"
end

# Added home route.
get /\A\/(home)?\z/ do
  @page = 'home'
  @destinations = get_location_overview()
  if @destinations != nil && (not @destinations.empty?)
    @departing_station_name = (@destinations.first)["departing_station_name"]
  else
    @departing_station_name = "Not found (IP: " + get_browser_ip() + ")"
  end
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

def get_location_overview()
  current_ip = get_browser_ip()
  
  weathers_url = @heroku_api + "/weathers?ip=" + current_ip
  weathers_uri = URI(URI::encode(weathers_url))
  weathers_response = Net::HTTP.get_response(weathers_uri)
  weathers = JSON.parse(weathers_response.body)
  destinations = weathers["weathers"]
  return destinations
end
