# server.rb
require 'sinatra'
require 'json'
require_relative 'createProject.rb'
require_relative 'getProject.rb'
require_relative 'getProjects.rb'
require_relative 'deleteProject.rb'
get '/' do
  status 200
  return 'Welcome to cms!'
end

get '/projects',:provides=>:json do
  puts request.env["CONTENT_TYPE"]
  body = getProjects()
  puts body  
  status 200
  return body
end 

get '/project/:id',:provides=>:json do
  param = params[:id]
  searchId = param[3,param.length]
  project = getProject(searchId)
  status 200
  return project
end

delete '/project/:id',:provides=>:json do
  param = params[:id]
  searchId = param[3,param.length]
  response = deleteProject(searchId)
  status 204
  puts response
  return response
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

