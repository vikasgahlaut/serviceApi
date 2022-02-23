require 'mysql2'
require 'json'
require 'uuid'
require 'logger'

# Create a Logger that prints to STDOUT
log = Logger.new(STDOUT)

def createProject(body)
  jsonBody = JSON.parse(body) 
  client = Mysql2::Client.new(:host => "192.168.1.134", :port => "3306", :username => "db", :password => "Bajaj@3901")
  id = UUID.new.generate
  insertQuery = "INSERT INTO cmsDB.PROJECTS (`projectId`, `projectName`, `projectType`, `clientApp`) VALUES ('#{id}', '#{jsonBody['projectName']}', '#{jsonBody['projectType']}', '#{jsonBody['clientApp']}' );"
  #log = Logger.new(STDOUT)
  log.info(insertQuery)
  client.query(insertQuery)
  
  testHash = {
    :id => id,
    :name => "#{jsonBody['projectName']}"
  }
  #testHash["id"] = "#{jsonBody['projectId']}"
  log.info(testHash.to_json())
  return testHash.to_json()
end

def getProjects
  client = Mysql2::Client.new(:host => "192.168.1.134", :port => "3306", :username => "db", :password => "Bajaj@3901")
  projects = []
  client.query("select * from cmsDB.PROJECTS") .each do |row|
    projects.push(row)
  end
  log.info(projects)
  return projects.to_json() 
end

def getProject(id)
  client = Mysql2::Client.new(:host => "192.168.1.134", :port => "3306", :username => "db", :password => "Bajaj@3901")
  getQuery = "select * from cmsDB.PROJECTS WHERE projectId = '#{id}'"
  puts getQuery
  project = []
  client.query(getQuery) .each do |row|
    project.push(row)  
  end
  log.info(project.to_json())
  return project.to_json() 
end

def deleteProject(id)
  client = Mysql2::Client.new(:host => "192.168.1.134", :port => "3306", :username => "db", :password => "Bajaj@3901")
  deleteQuery = "DELETE FROM cmsDB.PROJECTS WHERE projectId = '#{id}'"
  client.query(deleteQuery)
  log.info('Project Deleted Successfully')
  return 'Project Deleted Successfully' 
end
