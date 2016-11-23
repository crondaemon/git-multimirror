require 'git'

def setup_working_dir(project, logger)
	if Dir.exists?("#{project['path']}/#{project['name']}")
		logger.info("Project #{project['name']} already cloned")
		g = Git.open("#{project['path']}/#{project['name']}", :log => logger)
		g.remotes.each do |remote|
			g.remote(remote.name).remove
		end
		g.add_remote('origin', project['source'])
	else
		logger.info("Cloning #{project['name']} into #{project['path']}/#{project['name']}")
		g = Git.clone(project['source'], project['name'], :path => project['path'],
			:log => logger)
	end
	project['destinations'].each do |destination|
		g.add_remote(destination['name'], destination['url'])
	end
	return g
end

def pull_push(g, logger)
	logger.info("Downloading changes from #{g.remote('origin').name}")
	g.pull
	g.remotes.each do |remote|
		# skip origin
		next if remote.name == 'origin'
		logger.info("Pushing changes to #{remote.name}")
		g.push(remote)
	end
end
