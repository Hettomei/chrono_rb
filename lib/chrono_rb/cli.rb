require 'thor'
require 'date'

module ChronoRb
  class CLI < Thor

    desc "start", "Start chrono. Must be stopped"
    def start
      group = DateTime.now.strftime("%Y-%m-%d")
      puts "starting chrono for group #{group}"
    end

    desc "stop", "Stop chrono. Must be started"
    def stop
      group = DateTime.now.strftime("%Y-%m-%d")
      ChronoRb.exit_with_error("Error chrono must be started for group #{group}")
    end

  end
end
