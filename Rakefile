require 'rake/clean'

desc 'Run basic checks'
task :check do
  unless ENV.has_key?('HIPCHAT_API_TOKEN')
    puts "ERROR: HIPCHAT_API_TOKEN not set.  Please set with your HipChat API token: hipchat.com/account/api"
  end
end

desc 'Start the IRC2HipChat daemon'
task :start do
  command = "bundle exec god -c irc2hipchat.god"
  STDERR.puts(command) if verbose
  exec(command)
end

desc 'Stop the IRC2HipChat daemon'
task :stop do
  command = "bundle exec god stop irc2hipchat"
  STDERR.puts(command) if verbose
  exec(command)
end

