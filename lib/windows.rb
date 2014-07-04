require "win32/service"
include Win32

class IRC2HipChat
  class Windows
    class << self
       ##
       # Register IRC2Hipchat as a Windows Service
       #
      def register_service

        Service.create({
          :service_name => 'irc2hipchat',
          :host => nil,
          :service_type => Service::WIN32_OWN_PROCESS,
          :description => 'Log all messages from an IRC channel to a HipChat room',
          :start_type => Service::AUTO_START,
          :error_control => Service::ERROR_NORMAL,
          :binary_path_name => "#{`where ruby`.chomp} -C #{`echo %cd%`.chomp} irc2hipchat.rb",
          :load_order_group => 'Network',
          :dependencies => nil,
          :display_name => 'IRC2HipChat'
        })
      end

      ##
      # Delete the IRC2Hipchat Service
      #
      def delete_service
        Service.delete("irc2hipchat")
      end
    end
  end
end
