IRC2HipChat
===========

Log all messages from an IRC channel to a HipChat room.

[IRC2HipChat](https://github.com/pglombardo/IRC2HipChat) is a short Ruby script that uses [Cinch](https://github.com/cinchrb/cinch) to monitor IRC and re-post messages to a dedicated HipChat room using the [HipChat API gem](https://rubygems.org/gems/hipchat).

```ruby
  on :channel do |m|
    msg = "<em>#{m.user.nick}</em>: #{m.message}"
    $hipchat.send('irc2hipchat', msg, { :notify => true, :message_format => 'html' })
  end
```

_Note: For now, this is a one way flow of traffic: To use a HipChat room to log IRC channel history.  I may pursue a full two-way IRC-to-HipChat bridge eventually but there are some complications to be addressed when trying to match HipChat users to IRC users.  TBD_

It uses [Godrb](http://godrb.com/) by default for daemonization and monitoring but you really could use any daemon spawning method you prefer.

# Background

[AppNeta](http://www.appneta.com) hosts the #appneta channel on [Freenode](http://freenode.net/) where we offer user support and answer questions.  Not as widely known, is that it's a great place to get direct chat time with the appneta team behind the scenes.  On a normal day, we have developers, sales, support and some executives all logged into IRC.

Internally we use [HipChat](http://www.hipchat.com) and [Dan Riti](https://github.com/danriti) setup this bot so if someone types 'helpme' a notification gets sent to HipChat to ping the team that someone needs help in IRC.  It works great.

My problem was that when I forgot to boot [LimeChat for Mac](http://limechat.net/mac/), I would log in and have zero chat history.  I know I should instead have a dedicated $5 VM running [screen](http://www.gnu.org/software/screen/) and [irssi](http://www.irssi.org/) somewhere but I just don't have the interest and I especially don't like screen.  So what's the logical next step?  Leverage some existing Ruby gems to create an IRC to HipChat Relay in [about 25 lines of code](https://github.com/pglombardo/IRC2HipChat/blob/master/irc2hipchat.rb).

# How it Looks

![irc2hipchat preview](https://s3.amazonaws.com/pglombardo/irc2hipchat_preview.png?x=1)

# How to Use It

1. Got Ruby?  Checkout [rbenv](https://github.com/sstephenson/rbenv) if you don't.


2. Clone the repository

    ```bash
    git clone https://github.com/pglombardo/IRC2HipChat.git
    ```
  
3. Set your environment variables

    ```bash
      # Get your HipChat api token: http://www.hipchat.com/account/api
      # or even better use a labeled Room Notification Token for better presentation
      echo "export HIPCHAT_API_TOKEN=xxx" >> ~/.bash_profile
    ```

  *Ubuntu Desktop note*: Modify your ~/.bashrc instead of ~/.bash_profile.

  *Zsh note*: Modify your ~/.zshrc file instead of ~/.bash_profile.
  
4. Configure your HipChat room and IRC channel in `config.yml`

    ```yaml
    ---
    HipChatRoom: AppNetaIRCLog
    IRCChannel: '#appneta'
    IRCServer: irc.freenode.org
    IRCNick: irc2hipchat
    ```

5. Restart your shell so the new environment variables take affect

6. Bundle install

    ```bash
    bundle install
    ```

7. Start the daemon

    ```bash
    bundle exec rake start
    ```
    
    __Windows Users:__ Until [this PR](https://github.com/pglombardo/IRC2HipChat/pull/2) is finished and merged, run the following in a terminal instead:
    
    ```
    ruby irc2hipchat.rb
    ```

# Monitoring and Performance

Being AppNeta, we like to monitor performance of all things.  If you don't have a TraceView account, [sign up.  It's free](http://www.appneta.com/products/traceview/).

If you have TraceView setup and installed on your host, IRC2HipChat will automatically report statistics to your dashboard.

![irc2hipchat traces](https://s3.amazonaws.com/pglombardo/irc2hipchat_traces.png)



