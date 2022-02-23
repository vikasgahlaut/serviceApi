require 'mysql2'
require 'json'
require 'uuid'
require 'logger'

# Create a Logger that prints to STDOUT
$log = Logger.new(STDOUT)

def createProject(body)
  jsonBody = JSON.parse(body) 
  client = Mysql2::Client.new(:host => "192.168.1.134", :port => "3306", :username => "db", :password => "Bajaj@3901")
  id = UUID.new.generate
  insertQuery = "INSERT INTO cmsDB.PROJECTS (`projectId`, `projectName`, `projectType`, `clientApp`) VALUES ('#{id}', '#{jsonBody['projectName']}', '#{jsonBody['projectType']}', '#{jsonBody['clientApp']}' );"
  client.query(insertQuery)
  $log.info('Query Executed: ' + insertQuery)

  testHash = {
    :id => id,
    :name => "#{jsonBody['projectName']}"
  }
  return testHash.to_json()
end

def getProjects
  client = Mysql2::Client.new(:host => "192.168.1.134", :port => "3306", :username => "db", :password => "Bajaj@3901")
  projects = []
  getsQuery = "select * from cmsDB.PROJECTS"
  $log.info('Query Executed: ' + getsQuery)
  client.query(getsQuery) .each do |row|
    projects.push(row)
  end
  return projects.to_json() 
end

def getProject(id)
  client = Mysql2::Client.new(:host => "192.168.1.134", :port => "3306", :username => "db", :password => "Bajaj@3901")
  getQuery = "select * from cmsDB.PROJECTS WHERE projectId = '#{id}'"
  $log.info('Query Executed: ' + getQuery)
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
  client.query(deleteQuery)
  return 'Project Deleted Successfully' 
end
