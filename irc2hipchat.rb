require 'rubygems'
require 'bundler'
Bundler.require(:default)
require 'yaml'

unless ENV.has_key?('HIPCHAT_API_TOKEN')
  abort 'Set HIPCHAT_API_TOKEN environment variable with your HipChat API Token: https://hipchat.com/account/api'
end

$conf = YAML::load_file(File.join(__dir__, 'config.yml'))

hipchat_cli = HipChat::Client.new(ENV['HIPCHAT_API_TOKEN'], :api_version => 'v2')
hc_room = $conf['HipChatRoom']

$hipchat = hipchat_cli[hc_room]

bot = Cinch::Bot.new do
  configure do |c|
    c.nick     = $conf['IRCNick']
    c.server   = $conf['IRCServer']
    c.channels = [ $conf['IRCChannel'] ]
  end

  # Only log channel messages
  on :channel do |m|
    msg = "<b>#{m.user.nick}</b>: #{m.message}"
    $hipchat.send('irc2hipchat', msg, { :notify => true, :color => 'green', :message_format => 'html' })
  end
end

bot.start

