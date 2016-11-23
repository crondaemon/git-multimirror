
def validate_project(project)
	return false if !project['name']
	return false if !project['source']
	return false if !project['path']
	return false if !project['destinations']
	return false if project['destinations'].size < 1
	project['destinations'].each do |destination|
		return false if !destination['name'] || !destination['url']
	end
	return true
end
