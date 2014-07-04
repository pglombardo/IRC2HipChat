require "win32/service"
include Win32

# We have no good way to detect where Ruby is installed unfortunately
# Update this line with the fully qualified path to your ruby executable
RUBY_EXECUTABLE="C:\\Ruby200\\bin\\ruby"

class IRC2HipChat
  class Windows
    class << self
       ##
       # Register IRC2Hipchat as a Windows Service
       #
      def register_service
        unless File.exists?(RUBY_EXECUTABLE)
          abort("Sorry: We can't find your Ruby executable.  Please update" +
                "lib/windows.rb line 6 with the full path to your Ruby executable.")
        end

        Service.create({
          :service_name => 'IRC2HipChat',
          :host => nil,
          :service_type => Service::WIN32_OWN_PROCESS,
          :description => 'Log all messages from an IRC channel to a HipChat room',
          :start_type => Service::AUTO_START,
          :error_control => Service::ERROR_NORMAL,
          # Windows Services need a fully qualified path to the ruby binary.
          # Update this path and delete/re-add the service if it's broken for you
          :binary_path_name => "#{RUBY_EXECUTABLE} -C #{`echo %cd%`.chomp} irc2hipchat.rb",
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
