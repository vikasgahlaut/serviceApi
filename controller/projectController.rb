require 'mysql2'
require 'json'
require 'uuid'
def createProject(body)
  jsonBody = JSON.parse(body) 
  client = Mysql2::Client.new(:host => "192.168.1.134", :port => "3306", :username => "db", :password => "Bajaj@3901")
  id = UUID.new.generate
  #puts id
  insertQuery = "INSERT INTO cmsDB.PROJECTS (`projectId`, `projectName`, `projectType`, `clientApp`) VALUES ('#{id}', '#{jsonBody['projectName']}', '#{jsonBody['projectType']}', '#{jsonBody['clientApp']}' );"
  puts insertQuery
  client.query(insertQuery)
  
  testHash = {
    :id => id,
    :name => "#{jsonBody['projectName']}"
  }
  #testHash["id"] = "#{jsonBody['projectId']}"
  puts testHash.to_json()
  return testHash.to_json()
end

def getProjects
  client = Mysql2::Client.new(:host => "192.168.1.134", :port => "3306", :username => "db", :password => "Bajaj@3901")
  projects = []
  client.query("select * from cmsDB.PROJECTS") .each do |row|
    projects.push(row)
  end
  puts projects
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
  puts project.to_json()
  return project.to_json() 
end

def deleteProject(id)
  client = Mysql2::Client.new(:host => "192.168.1.134", :port => "3306", :username => "db", :password => "Bajaj@3901")
  deleteQuery = "DELETE FROM cmsDB.PROJECTS WHERE projectId = '#{id}'"
  client.query(deleteQuery)
  return 'Project Deleted Successfully' 
end
