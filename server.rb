require 'sinatra'
require 'rest-client'
require 'pry-byebug'

set :bind, '0.0.0.0'

@host = "http://movies.api.mks.io"

get '/' do
  p params
  erb :index
end

get '/movies' do
  url = "http://movies.api.mks.io/movies"
  response = RestClient.get(url, accept: 'application/json')
  @movies = JSON.parse(response.body)
  p @movies
  erb :"movies/index"
end

get '/actors' do
  url = "http://movies.api.mks.io/actors"
  response = RestClient.get(url, accept: 'application/json')
  @actors = JSON.parse(response.body)
  p @actors
  erb :"actors/index"
end

get '/movies/:id' do
  movie_id = params[:id]
  url = "http://movies.api.mks.io/movies/" + movie_id
  response = RestClient.get(url, accept: 'application/json')
  @movie = JSON.parse(response.body)
  url += "/actors"
  response = RestClient.get(url, accept: 'application/json')
  @actors = JSON.parse(response.body)
  erb :"movies/showpage"  # This will look for a file called 'views/showpage.erb'  
end

get '/actors/:id' do
  actor_id = params[:id]
  url = "http://movies.api.mks.io/actors/" + actor_id
  response = RestClient.get(url, accept: 'application/json')
  @actor = JSON.parse(response.body)
  url += "/movies"
  response = RestClient.get(url, accept: 'application/json')
  @movies = JSON.parse(response.body)
  erb :"actors/showpage"  # This will look for a file called 'views/showpage.erb'  
end

# Write a Ruby method to show all actors for a given movie title.
def get_all_actors_for_movie(movie)
  url = "http://movies.api.mks.io/actors"
  response = RestClient.get(url, accept: 'application/json')

end

# Write a Ruby method to show all movies for a given actor (by name). 
# Show suggestions if the user typed in a name that has no matches.
def get_all_movies_for_actor(actor)
  url = "http://movies.api.mks.io/movies"
  response = RestClient.get(url, accept: 'application/json')

end