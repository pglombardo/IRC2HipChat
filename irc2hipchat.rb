require 'cinch'
require 'hipchat'

unless ENV.has_key?('HIPCHAT_API_TOKEN')
  abort 'Set HIPCHAT_API_TOKEN environment variable with your HipChat API Token: https://hipchat.com/account/api'
end

$hc_room = 'AppNetaIRCLog'
$hipchat_cli = HipChat::Client.new(ENV['HIPCHAT_API_TOKEN'], :api_version => 'v2')

def format_message(nick, message)
  "#{nick}: #{message}"
end

bot = Cinch::Bot.new do
  configure do |c|
    c.nick     = 'loggerbot'
    c.server   = 'irc.freenode.org'
    c.channels = ["#appneta"]
  end

  # Only log channel messages
  on :channel do |m|
    message = format_message(m.user.nick, m.message)
    $hipchat_cli[$hc_room].send(m.user.nick, message, :notify => true)
  end
end

bot.start

