require 'mysql2'
require 'json'
def getProjects
  #jsonBody = JSON.parse(body)
  client = Mysql2::Client.new(:host => "192.168.1.134", :port => "3306", :username => "db", :password => "Bajaj@3901")
  #insertQuery = "INSERT INTO cmsDB.PROJECTS (`projectId`, `projectName`) VALUES ('#{jsonBody['productionId']}', '#{jsonBody['name']}' );"
  #puts insertQuery
  #client.query(insertQuery);

  projects = []

  client.query("select projectId from cmsDB.PROJECTS") .each do |row|
    projects.push(row)
    puts row
  end
  return projects.to_json() 
end


