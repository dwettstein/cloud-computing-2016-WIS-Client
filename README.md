# WIS-client
Simple web page for REST calls, teaching project for purpose of practical works.

# Description of our progress

## Setup

TODO: David

## RESTful-APIs

Our web service uses the following three APIs in order to get information about public transportation schedules, geographical data and weather conditions:

- [IP-API.com](http://ip-api.com/) - Geolocation API
- [Transport Opendata CH](http://transport.opendata.ch/) - Swiss public transport API
- [OpenWeatherMap](http://openweathermap.org/)

First, we implemented the in detail described IP request `/ip`. This route takes `ip` as a parameter and responses the location of the IP. As all further routes also have to forward the request to another API (Geolocation, Transport, Weather), we defined a function `forwardRequest` which makes a HTTP GET request to a given URI and returns its response as JSON.

After that, we implemented the route `/locations` which forwards all given parameters to the transport opendata API. However, either `query` or the coordinates `x` and `y` are mandatory otherwise an error message is shown.  The logic of the routes `/connectoins` and `/stationboard` is implemented according to `/location` and does not need any further explanation.
The next route is `/weather`. As web requests for current as well as future weather data are almost identical, we sourced those two requests (`/weather`, `/weathers` and `/future_weathers`) out into the function `doWeatherRequest` which takes except for the GET parameter a boolean if it is a current or a future weather data request.

The `/stations` route takes `ip` as a parameter and looks up with a `/ip` request what location the IP corresponds. In combination with the latitude/longitude of the response and the `/location` request, the nearest train stations can be found. After that, a `/stationboard` request with the parameters `id=STATION_ID_OF_RESPONSE` and `limit=5` is enough to get the next train connections running from the nearest train station of this IP location. However, the `limit=5` parameter can respond more than 5 elements if the train leaves on the same time. Therefore, the an additional filter `first(5)` on the JSON response must be applied.

The `/weathers` request takes `ip` as a parameter and forwards the IP to the `/stations` request in order to get the next train connections running from the nearest train station of this IP location. With this response, the latitude/longitude coordinates of these locations can be extracted and forwarded to the `doWeatherRequest` function to get the corresponding weather data. This route responses a list of paris <destination, weather>.

The `/future_weathers` route is similar to the `/weather` route except for the parameter `x` which is a mandatory parameter and describes how many days in the future the weather should be responded. As the external weather API does not offer such kind of search criteria, we had to exctract the date of the future weather data and filter that according to the `x` parameter (DateTime.now <= weather_date <= DateTime.now + x-days).

In addition, the routes `/weathers` and `/future_weathers` support sorting. The data can be sorted by adding the optional parameter `sort` with one of the following values: `temperature`, `humidity`, `pressure`, `wind`, `cloud`. If no sort parameter is present, the data is sorted by the temperature.


### Error handling

As web service requests mostly have required and optional parameters, we decided to implement an user friendly error handling by sending an error message to the user with an explanation what went wrong. As this procedure is used in almost all web service requests, an additional function named `doError` is defined which creates the corresponding JSON error response. Because most functions need error handling, we define two helper functions `hasAllParams` and `hasOneParam` to check if a request has the designated parameters.


## GUI-client

TODO: David

### SLIM

TODO: David

## Conclusion

TODO: David