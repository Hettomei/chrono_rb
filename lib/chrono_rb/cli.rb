require 'thor'
require 'chrono_rb/add'
require 'chrono_rb/conf'
require 'chrono_rb/delete'
require 'chrono_rb/entries'
require 'chrono_rb/groups'
require 'chrono_rb/start_stop'

module ChronoRb
  class CLI < Thor

    default_task :start_stop

    GROUP_DESC="[--group=GROUP]"

    desc "start_stop #{GROUP_DESC}", "Start or Stop chrono. This is the default task"
    option :group, aliases: [:g]
    def start_stop
      conf.set_group(options[:group]) if options[:group]
      StartStop.new(config: conf).call
      puts "Starting chrono for group #{conf.group}"
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

    desc "show #{GROUP_DESC} [--now]", "Show all chrono. if --now, compare against now and do not save this one"
    option :group, aliases: [:g]
    option :now, aliases: [:n], :type => :boolean
    def show
      conf.set_group(options[:group]) if options[:group]
      puts "#{conf.group}:"
      if options[:now]
        Entries.new(config: conf).display_with_now
      else
        display_group
      end
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
