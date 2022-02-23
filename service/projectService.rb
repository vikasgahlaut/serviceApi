# server.rb
require 'sinatra'
require 'json'
require 'logger'
require_relative '../controller/projectController.rb'


# Create a Logger that prints to STDOUT
log = Logger.new(STDOUT)

get '/' do
  status 200
  return 'Welcome to cms!'
end

get '/projects',:provides=>:json do
  puts request.env["CONTENT_TYPE"]
  body = getProjects()
  log.info(body)  
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
  log.info(response)
  return response
end

post '/project/create', :provides=>:json do
  log.info(request.env["CONTENT_TYPE"])
  log.info(request.env["AUTHORIZATION"])
  #puts request.body.read
  body = request.body.read
  log.info(body)
  object = JSON.parse(body)
  log.info(object["projectId"])
  log.info(object["projectName"])
  log.info(object["projectType"])
  log.info(object["clientApp"])
  response = createProject(body)
  status 200
  return response
end

