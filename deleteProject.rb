require 'mysql2'
require 'json'
def deleteProject(id)
  client = Mysql2::Client.new(:host => "192.168.1.134", :port => "3306", :username => "db", :password => "Bajaj@3901")
  deleteQuery = "DELETE FROM cmsDB.PROJECTS WHERE projectId = '#{id}'"
  client.query(deleteQuery)
  return 'Project Deleted Successfully' 
end
