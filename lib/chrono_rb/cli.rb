require 'thor'
require 'chrono_rb/conf'
require 'chrono_rb/delete'
require 'chrono_rb/entries'
require 'chrono_rb/auto'
require 'chrono_rb/start'
require 'chrono_rb/stop'

module ChronoRb
  class CLI < Thor

    default_task :auto

    GROUP_DESC="[--group=GROUP]"

    desc "auto #{GROUP_DESC}", "Start or Stop chrono. This is the default task"
    option :group, aliases: [:g]
    def auto
      conf.set_group(options[:group]) if options[:group]
      auto = Auto.new(config: conf)
      if auto.auto == 'start'
        invoke :start
      else
        invoke :stop
      end
    end

    desc "start #{GROUP_DESC}", "Start chrono. Must be stopped."
    option :group, aliases: [:g]
    def start
      conf.set_group(options[:group]) if options[:group]
      start = Start.new(config: conf)
      start.start
      puts "Starting chrono for group #{conf.group}"
      display_group
    end

    desc "stop #{GROUP_DESC}", "Stop chrono. Must be started."
    option :group, aliases: [:g]
    def stop
      conf.set_group(options[:group]) if options[:group]
      stop = Stop.new(config: conf)
      stop.stop
      puts "Stoping chrono for group #{conf.group}"
      display_group
    end

    desc "del #{GROUP_DESC}", "Delete the last entry."
    option :group, aliases: [:g]
    def del
      conf.set_group(options[:group]) if options[:group]
      del = Delete.new(config: conf)
      del.del
      puts "Deleting last entry #{del.del} for group #{conf.group}"
      display_group
    end

    desc "show #{GROUP_DESC}", "Show all chrono."
    option :group, aliases: [:g]
    def show
      conf.set_group(options[:group]) if options[:group]
      puts "Group #{conf.group}"
      display_group
    end

    desc "groups", "Display all existing groups."
    def groups
      biggest = 0
      array = []
      conf.store.roots.sort.map do |group|
        next if group == conf.group_name.to_s

        entries_count = conf.store.fetch(group, []).count

        biggest = group.size if group.size > biggest

        array << [group, entries_count]
      end

      array.each do |name, size|
        puts "#{name.ljust(biggest)} : #{size}"
      end
    end

    no_commands do
      def conf
        @conf ||= Conf.new
      end

      def display_group
        Entries.new(config: conf).display
      end
    end

  end
end
