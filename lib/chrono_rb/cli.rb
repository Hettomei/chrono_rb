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

    desc "show", "Show chrono."
    option :group, aliases: [:g]
    def show
      conf.set_group(options[:group]) if options[:group]
      puts "Showing chrono for group #{conf.group}"
      display_group
    end

    desc "test", "test chrono"
    def test
      conf.set_group('test-01')
      start = Start.new(config: conf)
      stop = Stop.new(config: conf)
      start.start(DateTime.new(2017,3,13,9))
      stop.stop(DateTime.new(2017,3,13,12,30))
      start.start(DateTime.new(2017,3,13,13,30))
      stop.stop(DateTime.new(2017,3,13,17,30))

      start.start(DateTime.new(2017,3,14,9))
      stop.stop(DateTime.new(2017,3,14,12,30))
      start.start(DateTime.new(2017,3,14,13,30))
      stop.stop(DateTime.new(2017,3,14,17,30))

      start.start(DateTime.new(2017,3,15,9))
      stop.stop(DateTime.new(2017,3,15,12,30))
      start.start(DateTime.new(2017,3,15,13,30))
      stop.stop(DateTime.new(2017,3,15,17,30))

      start.start(DateTime.new(2017,3,16,9))
      stop.stop(DateTime.new(2017,3,16,12,30))
      start.start(DateTime.new(2017,3,16,13,30))
      stop.stop(DateTime.new(2017,3,16,17,30))

      start.start(DateTime.new(2017,3,17,9))
      stop.stop(DateTime.new(2017,3,17,12,30))
      start.start(DateTime.new(2017,3,17,13,30))
      stop.stop(DateTime.new(2017,3,17,17,30))
      puts "Starting chrono for group #{conf.group}"
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
