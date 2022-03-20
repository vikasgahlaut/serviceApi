require 'mysql2'
require 'json'
require 'uuid'
require 'logger'
require_relative '../service/projectService.rb'
require_relative '../controller/exceptions.rb'

def createProject(body)
  begin
    jsonBody = JSON.parse(body)
    begin
      client = Mysql2::Client.new(:host => "192.168.1.134", :port => "3306", :username => "db", :password => "Bajaj@3901")
      id = UUID.new.generate
      insertQuery = "INSERT INTO cmsDB.PROJECTS (`projectId`, `projectName`, `projectType`, `clientApp`) VALUES ('#{id}', '#{jsonBody['projectName']}', '#{jsonBody['projectType']}', '#{jsonBody['clientApp']}' );"
      begin  
        client.query(insertQuery)
        $log.info('Query Executed: ' + insertQuery)
        #$logs.info('Query Executed: ' + insertQuery)
        testHash = {
        :id => id,
        :name => "#{jsonBody['projectName']}"
        }
        response =  testHash.to_json()
      rescue Exception => e
        $log.error('Unable to execute query, Please check syntax.')
        #$logs.error('Unable to execute query, Please check syntax.')
        response = 'Unable to execute query, Please check syntax.'
      end  
    rescue Exception => e
      $log.error('Unable to connect to database.')
      response = 'Unable to connect to database.'
    end
  rescue Exception => e
    $log.error('Unable to parse JSON.')
    response = 'Unable to parse JSON.' 
  end  
return response
end

def getProjects
  client = Mysql2::Client.new(:host => "192.168.1.134", :port => "3306", :username => "db", :password => "Bajaj@3901")
  projects = []
  getsQuery = "select * from cmsDB.PROJECTS"
  $log.info('Query Executed: ' + getsQuery)
  #$logs.info('Query Executed: ' + getsQuery)
  client.query(getsQuery) .each do |row|
    projects.push(row)
  end
  return projects.to_json() 
end

def getProject(id)
  client = Mysql2::Client.new(:host => "192.168.1.134", :port => "3306", :username => "db", :password => "Bajaj@3901")
  getQuery = "select * from cmsDB.PROJECTS WHERE projectId = '#{id}'"
  $log.info('Query Executed: ' + getQuery)
  #$logs.info('Query Executed: ' + getQuery)
  project = []
  client.query(getQuery) .each do |row|
    project.push(row)  
  end
  return project.to_json() 
end

def deleteProject(id)
  client = Mysql2::Client.new(:host => "192.168.1.134", :port => "3306", :username => "db", :password => "Bajaj@3901")
  deleteQuery = "DELETE FROM cmsDB.PROJECTS WHERE projectId = '#{id}'"
  $log.info('Query Executed: ' + deleteQuery)
  #$logs.info('Query Executed: ' + deleteQuery)
  client.query(deleteQuery)
  return 'Project Deleted Successfully' 
end
