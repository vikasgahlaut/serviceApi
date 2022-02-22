require_relative '../controller/projectController.rb'
id = ARGV[0]
res = deleteProject(id)
puts res
