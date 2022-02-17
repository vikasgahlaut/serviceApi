require 'mysql2'
require 'json'
def createProject(body)
  jsonBody = JSON.parse(body) 
  client = Mysql2::Client.new(:host => "192.168.1.134", :port => "3306", :username => "db", :password => "Bajaj@3901")
  insertQuery = "INSERT INTO cmsDB.PROJECTS (`projectId`, `projectName`, `projectType`, `clientApp`) VALUES ('#{jsonBody['projectId']}', '#{jsonBody['projectName']}', '#{jsonBody['projectType']}', '#{jsonBody['clientApp']}' );"
  puts insertQuery
  client.query(insertQuery);

  response = []
  client.query("select * from cmsDB.PROJECTS WHERE projectId = '#{jsonBody['projectId']}'") .each do |row|
    response.push(row) 
  end
  return response.to_json()
end

