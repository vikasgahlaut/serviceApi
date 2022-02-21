require 'mysql2'
require 'json'
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
