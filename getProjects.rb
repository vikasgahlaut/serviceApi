require 'mysql2'
require 'json'
def getProjects
  client = Mysql2::Client.new(:host => "192.168.1.134", :port => "3306", :username => "db", :password => "Bajaj@3901")
  projects = []
  client.query("select * from cmsDB.PROJECTS") .each do |row|
    projects.push(row)
  end
  puts projects
  return projects.to_json() 
end


