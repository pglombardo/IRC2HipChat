require 'cinch'
require 'hipchat'

unless ENV.has_key?('HIPCHAT_API_TOKEN')
  abort 'Set HIPCHAT_API_TOKEN environment variable with your HipChat API Token: https://hipchat.com/account/api'
end

$hc_room = 'AppNetaIRCLog'
$hipchat_cli = HipChat::Client.new(ENV['HIPCHAT_API_TOKEN'], :api_version => 'v2')

bot = Cinch::Bot.new do
  configure do |c|
    c.nick     = 'irc2hipchat'
    c.server   = 'irc.freenode.org'
    c.channels = ["#appneta"]
  end

  # Only log channel messages
  on :channel do |m|
    msg = "<em>#{m.user.nick}</em>: #{m.message}"
    $hipchat_cli[$hc_room].send('irc2hipchat', msg, { :notify => true, :color => 'green', :message_format => 'html' })
  end
end

bot.start

