require 'thor'
require 'chrono_rb/conf'
require 'chrono_rb/start'
require 'chrono_rb/delete'

module ChronoRb
  class CLI < Thor

    desc "start", "Start chrono. Must be stopped"
    def start
      start = Start.new(config: conf)
      start.start
      puts "Starting chrono for group #{conf.group}"
      puts "all:"
      start.entries.each do |entry|
        puts entry
      end
    end

    desc "del", "delete the last entry"
    def del
      del = Delete.new(config: conf)
      del.del
      puts "deleting last entry #{del.del} for group #{conf.group}"
      puts "all:"
      del.entries.each do |entry|
        puts entry
      end
    end

    desc "stop", "Stop chrono. Must be started"
    def stop
      group = DateTime.now.strftime("%Y-%m-%d")
      ChronoRb.exit_with_error("Error chrono must be started for group #{group}")
    end

    no_commands do
      def conf
        @conf ||= Conf.new
      end
    end

  end
end
