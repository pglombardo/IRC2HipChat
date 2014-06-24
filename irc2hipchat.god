require 'god'

unless ENV.has_key?('HIPCHAT_API_TOKEN')
  abort 'Set HIPCHAT_API_TOKEN environment variable with your HipChat API Token: https://hipchat.com/account/api'
end

God.watch do |w|
  w.name = 'irc2hipchat'
  w.start = 'bundle exec ruby irc2hipchat.rb'
end

