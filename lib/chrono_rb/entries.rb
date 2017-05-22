require 'date'

module ChronoRb
  class Entries

    ONE_DAY_IN_SEC = 3600 * 24

    def initialize(config:)
      @config = config
    end

    def display
      display_entries(store.fetch(@config.group, []))
    end

    def display_entries(entries)
      total = 0

      entries.each_slice(2) do |time1, time2|
        if time1 && time2
          diff_in_seconds = time2.to_time - time1.to_time
          total += diff_in_seconds
          puts "#{format(time1)} -> #{format(time2)} : #{format_sec_to_duration(diff_in_seconds)}"
        else
          puts format(time1)
        end
      end

      puts "Total: #{format_sec_to_duration(total)}"
    end

    def display_with_now
      a = store.fetch(@config.group, [])
      if a.last && a.last.length == 1
        a.last.concat([DateTime.now])
      else
        puts 'nothing to add'
      end
      display_entries(a)
    end

    def format(date)
      date.strftime("%Y-%m-%d %T %z")
    end

    def format_sec_to_duration(sec)
      str = ''

      if sec > ONE_DAY_IN_SEC - 1
        days = sec.round / ONE_DAY_IN_SEC
        str = "#{days} days %T"
      else
        str = '%T'
      end

      Time.at(sec % ONE_DAY_IN_SEC).utc.strftime(str)
    end

    def store
      @config.store
    end

  end
end
