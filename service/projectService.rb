# server.rb
require 'sinatra'
require 'json'
require 'logger'
require_relative '../controller/projectController.rb'
require 'fileutils'

#Create logs folder if it does not exists
logFolder = '../logs/'
Dir.mkdir(logFolder) unless File.exists?(logFolder)

# Create a loggers that prints to stdout and log file
$log = Logger.new('../logs/' + 'Log' + Time.now.getutc.to_s+'.log')
$logs = Logger.new(STDOUT)

get '/' do
  status 200
  response = 'Welcome to cms!'
  $log.info('Response: ' + response)
  $logs.info('Response: ' + response)
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
  $logs.info('Response: ' + response)
  return response
end

delete '/project/:id',:provides=>:json do
  param = params[:id]
  searchId = param[3,param.length]
  response = deleteProject(searchId)
  status 204
  $log.info('Response: ' + response)
  $logs.info('Response: ' + response)
  return response
end

post '/project/create', :provides=>:json do
  body = request.body.read
  $log.info('Body content:' + body)
  object = JSON.parse(body)
  response = createProject(body)
  status 200
  $log.info('Response: ' + response)
  $logs.info('Response: ' + response)
  return response
end

