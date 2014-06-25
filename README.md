IRC2HipChat
===========

IRC to HipChat Relay Daemon - Log all messages from an IRC channel to a HipChat room

[IRC2HipChat](https://github.com/pglombardo/IRC2HipChat) is a short Ruby script that uses [Cinch](https://github.com/cinchrb/cinch) to monitor IRC and re-post messages to a dedicated HipChat room using the [HipChat API gem](https://rubygems.org/gems/hipchat).

```ruby
  on :channel do |m|
    msg = "<em>#{m.user.nick}</em>: #{m.message}"
    $hipchat.send('irc2hipchat', msg, { :notify => true, :message_format => 'html' })
  end
```

_Note: For now, this is a one way flow of traffic: To use a HipChat room to log IRC channel history.  I may pursue a full two-way IRC-to-HipChat bridge eventually but there are some complications to be addressed when trying to match HipChat users to IRC users.  TBD_

It uses [Godrb](http://godrb.com/) by default for daemonization and monitoring but you really could use any daemon spawning method you prefer.

# How it Looks

![irc2hipchat preview](https://s3.amazonaws.com/pglombardo/irc2hipchat_preview.png)

# How to Use It

1. Clone the repository

    ```bash
    git clone https://github.com/pglombardo/IRC2HipChat.git
    ```
  
2. Set your environment variables

    ```bash
      # Get your HipChat api: http://www.hipchat.com/account/api
      # Switch to .bash_profile for non Ubuntu installations...
      echo "export HIPCHAT_API_TOKEN=xxx" >> ~/.bash_profile
    ```

  *Ubuntu Desktop note*: Modify your ~/.bashrc instead of ~/.bash_profile.

  *Zsh note*: Modify your ~/.zshrc file instead of ~/.bash_profile.
  
3. Configure your HipChat room and IRC channel in `config.yml`

    ```yaml
    ---
    HipChatRoom: AppNetaIRCLog
    IRCChannel: '#appneta'
    IRCServer: irc.freenode.org
    IRCNick: irc2hipchat
    ```

4. Restart your shell so the new environment variables take affect

5. Bundle install

    ```bash
    bundle install
    ```

6. Start the daemon

    ```bash
    bundle exec rake start
    ```
