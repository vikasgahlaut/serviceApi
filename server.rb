# server.rb
require 'sinatra'

get '/' do
  status 200
  return 'Welcome to cms!'
end

get '/medias' do
  status 300
  return ' List of all medias!'
end
get '/medias/:id' do
  status 400
  body 'Return media coressponding to id' + params[:id]  
end
post '/medias' do
  puts env 
  status 300
  return 'Create a media!'
end


