# server.rb
require 'sinatra'
require 'json'
require 'logger'
require_relative '../controller/projectController.rb'
require 'fileutils'

#Create logs folder if it does not exists
directory_name = '../logs/'
Dir.mkdir(directory_name) unless File.exists?(directory_name)

# Create a $logger that prints to STDOUT and another for log file
$logs = Logger.new(STDOUT)
$log = Logger.new('../logs/' + 'Log' + Time.now.getutc.to_s+'.log')

get '/' do
  status 200
  response = 'Welcome to cms!'
  $log.info('Response: ' + response)
  return response
end

get '/projects',:provides=>:json do
  puts request.env["CONTENT_TYPE"]
  response = getProjects()
  $log.info('Response: ' + response)  
  $logs.info('Response: ' + response)
  status 200
  return response
end 

get '/project/:id',:provides=>:json do
  param = params[:id]
  searchId = param[3,param.length]
  response = getProject(searchId)
  status 200
  $log.info('Response: ' + response) 
  return response
end

delete '/project/:id',:provides=>:json do
  param = params[:id]
  searchId = param[3,param.length]
  response = deleteProject(searchId)
  status 204
  $log.info('Response: ' + response)
  return response
end

post '/project/create', :provides=>:json do
  body = request.body.read
  $log.info('Body content:' + body)
  object = JSON.parse(body)
  response = createProject(body)
  status 200
  $log.info('Response: ' + response)
  return response
end

