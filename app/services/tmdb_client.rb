require "net/http"
require "uri"
require "json"

# https://api.themoviedb.org/3/search/movie = yesley TMDB lai bhanxa ki we want to search for movies
# ?query=Inception = this tell TMDB what movie we are searching for
#  #{URI.encode_www_form_component(query)} = dynamic query - to insert the user's search text
#  URI = converst the complete URL string into URI object so NET::HTTP can work with it
#  net::http expect uri object cause ruby can understand uri object and its part like
#  scheme ; http , host : api.themovie , path : /3/search/movie

class TmdbClient
  # this method return the matching movies from the movie DB
  def search_movies(query)
    # This creates a URI object that Net::HTTP can use.
    uri = URI("https://api.themoviedb.org/3/search/movie?query=
    #{URI.encode_www_form_component(query)}")

    # Net::HTTP::Get creates an HTTP GET request.
    # new(uri) tells the request which URL we want to access.
    # yesley request create garxa
    request = Net::HTTP::Get.new(uri)

    # TMDB access token using Bearer Token authentication.
    # Rails.application.credentials.dig(...) retrieves our encrypted TMDB token.
    request["Authorization"] = "Bearer #{Rails.application.credentials.dig(:tmdb, :access_token)}"

    # set response format = this tell tmdb we expect response  in JSON format
    request["accept"] = "application/json"

    # NET:HTTP.start = opens HTTP connection to server
    # uri.hostname = gest hostname from URL = api.themoviedb.org
    # uri.pot = gets port number. using https its 443
    # use_ssl: true = tells ruby to use a secure HTTPS connection
    # this sends the request
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    # this is called and ruby establish connection with server. Request server ma send huncha.
    # Server bata response aaucha.
    # Request complete bhayepachi connection close huncha (for the normal non-session request flow).
    response = http.request(request)

    # response.body gets the JSON response from TMDB.
    # JSON.parse() converts the JSON string into Ruby hashes and arrays.
    # paxi yesari data["results"] access garna milxa - gives the array of matching movies
    data = JSON.parse(response.body)

    # return the data
    data
  end

  def movie_details(movie_id)
    uri = URI("https://api.themoviedb.org/3/movie/#{movie_id}")

    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{Rails.application.credentials.dig(:tmdb, :access_token)}"
    request["accept"] = "application/json"

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    response = http.request(request)
    data = JSON.parse(response.body)

    data
  end

  def popular_movies
    uri = URI("https://api.themoviedb.org/3/movie/popular")

    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{Rails.application.credentials.dig(:tmdb, :access_token)}"
    request["accept"] = "application/json"

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    response = http.request(request)
    data = JSON.parse(response.body)

    data
  end
end
