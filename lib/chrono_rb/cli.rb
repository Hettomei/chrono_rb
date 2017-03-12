require 'thor'
require 'chrono_rb/conf'
require 'chrono_rb/delete'
require 'chrono_rb/entries'
require 'chrono_rb/start'
require 'chrono_rb/stop'

module ChronoRb
  class CLI < Thor

    desc "start", "Start chrono. Must be stopped"
    option :group, aliases: [:g]
    def start
      conf.set_group(options[:group]) if options[:group]
      start = Start.new(config: conf)
      start.start
      puts "Starting chrono for group #{conf.group}"
      display_group
    end

    desc "del", "delete the last entry"
    option :group, aliases: [:g]
    def del
      conf.set_group(options[:group]) if options[:group]
      del = Delete.new(config: conf)
      del.del
      puts "deleting last entry #{del.del} for group #{conf.group}"
      display_group
    end

    desc "roots", "all groups"
    def roots
      conf.store.roots.each do |entry|
        next if entry == conf.group_name.to_s
        puts entry
      end
    end

    desc "stop", "Stop chrono. Must be started"
    option :group, aliases: [:g]
    def stop
      conf.set_group(options[:group]) if options[:group]
      stop = Stop.new(config: conf)
      stop.stop
      puts "Stoping chrono for group #{conf.group}"
      display_group
    end

    no_commands do
      def conf
        @conf ||= Conf.new
      end

      def display_group
        puts "all:"
        Entries.new(config: conf).display
      end
    end

  end
end
