require 'thor'
require 'chrono_rb/add'
require 'chrono_rb/auto'
require 'chrono_rb/conf'
require 'chrono_rb/delete'
require 'chrono_rb/entries'
require 'chrono_rb/groups'
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
      if auto.call == 'start'
        invoke :start
      else
        invoke :stop
      end
    end

    desc "start #{GROUP_DESC}", "Start chrono. Must be stopped."
    option :group, aliases: [:g]
    def start
      conf.set_group(options[:group]) if options[:group]
      Start.new(config: conf).call
      puts "Starting chrono for group #{conf.group}"
      display_group
    end

    desc "stop #{GROUP_DESC}", "Stop chrono. Must be started."
    option :group, aliases: [:g]
    def stop
      conf.set_group(options[:group]) if options[:group]
      Stop.new(config: conf).call
      puts "Stoping chrono for group #{conf.group}"
      display_group
    end

    desc "add #{GROUP_DESC}", "Add by hand. Format is 2017-05-05 13:24:33"
    option :group, aliases: [:g]
    def add(*params)
      conf.set_group(options[:group]) if options[:group]
      str_datetime = params.join(' ')
      add = Add.new(config: conf, str_datetime: str_datetime)
      puts "Add chrono #{str_datetime} for group #{conf.group}"
      if !add.call
        puts
        puts add.get_error
        puts
      end
      display_group
    end

    desc "del #{GROUP_DESC}", "Delete the last entry."
    option :group, aliases: [:g]
    def del
      conf.set_group(options[:group]) if options[:group]
      entry = Delete.new(config: conf).call
      puts "Deleting last entry #{entry} for group #{conf.group}"
      display_group
    end

    desc "show #{GROUP_DESC}", "Show all chrono."
    option :group, aliases: [:g]
    def show
      conf.set_group(options[:group]) if options[:group]
      puts "#{conf.group}:"
      display_group
    end

    desc "group [--set=GROUP|--unset]", "Set/unset permanent group. Will take this group if no --group added."
    option :set, aliases: [:s]
    option :unset, aliases: [:u], :type => :boolean
    def group
      if options[:set]
        puts "group set to <#{options[:set]}>"
        conf.store.set_group(options[:set])
      elsif options[:unset]
        puts "group was <#{conf.group}>"
        conf.store.unset_group
      else
        puts "group is <#{conf.group}>"
      end
    end

    desc "groups", "Display all existing groups."
    def groups
      Groups.new(config: conf).call
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
