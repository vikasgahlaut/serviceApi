# server.rb
require 'sinatra'
require 'json'
require_relative 'createProject.rb'
require_relative 'getProjects.rb'
get '/' do
  status 200
  return 'Welcome to cms!'
end

get '/projects',:provides=>:json do
  puts request.env["CONTENT_TYPE"]
  body = getProjects()
  #object = JSON.parse(body)
  puts body  
  status 200
  return body
end 
get '/medias' do
  status 300
  return ' List of all medias!'
end
get '/medias/:id' do
  status 400
  body 'Return media coressponding to id' + params[:id]  
end
post '/medias', :provides=>:json do
  puts request.env["CONTENT_TYPE"]
  puts request.body.read 
  status 300
  return 'Create a media!'
end
post '/project/create', :provides=>:json do
  puts request.env["CONTENT_TYPE"]
  puts request.env["AUTHORIZATION"]
  #puts request.body.read
  body = request.body.read
  puts body
  object = JSON.parse(body)
  puts  object["projectId"]
  puts  object["projectName"]
  puts  object["projectType"]
  puts  object["clientApp"]
  response = createProject(body)
  status 200
  return response
end

