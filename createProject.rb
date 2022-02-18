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

