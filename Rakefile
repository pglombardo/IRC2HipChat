$:.unshift File.dirname(__FILE__) + "/lib"

require 'rubygems'

desc 'Run basic checks'
task :check do
  unless ENV.has_key?('HIPCHAT_API_TOKEN')
    puts "ERROR: HIPCHAT_API_TOKEN not set.  Please set with your HipChat API token: hipchat.com/account/api"
  end
end

desc 'Start the IRC2HipChat daemon'
task :start do
  if RUBY_PLATFORM =~ /djgpp|(cyg|ms|bcc)win|mingw/
    abort "Windows Users: Run 'rake register' and then start the service with 'sc start irc2hipchat'"
  end

  command = "bundle exec god -c irc2hipchat.god"
  STDERR.puts(command) if verbose
  exec(command)
end

desc 'Stop the IRC2HipChat daemon'
task :stop do
  if RUBY_PLATFORM =~ /djgpp|(cyg|ms|bcc)win|mingw/
    abort "Windows Users: Use 'sc stop irc2hipchat' or the Windows Service Control Panel to stop."
  end

  command = "bundle exec god stop irc2hipchat"
  STDERR.puts(command) if verbose
  exec(command)
end

##
# Windows Tasks
#

if RUBY_PLATFORM =~ /djgpp|(cyg|ms|bcc)win|mingw/
  # Windows Specific Tasks

  require 'windows'

  desc 'Register irc2hipchat as a Windows Service'
  task :register_service do
    IRC2HipChat::Windows.register_service
  end

  desc 'Register irc2hipchat as a Windows Service'
  task :delete_service do
    IRC2HipChat::Windows.delete_service
  end
end
