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

      entries.each_slice(2) do |date_time1, date_time2|
        if date_time1 && date_time2
          diff_in_seconds = date_time2.to_time - date_time1.to_time
          total += diff_in_seconds
          puts "#{format_date_time(date_time1)} -> #{format_date_time(date_time2)} : #{format_duration(diff_in_seconds)} | sum: #{format_duration(total)}"
        else
          puts format_date_time(date_time1)
        end
      end
    end

    def display_with_now
      display_entries(store.fetch(@config.group, []).concat([DateTime.now]))
    end

    def format_date_time(date)
      date.strftime("%Y-%m-%d %T %z")
    end

    def format_duration(sec)
      round_sec = sec.round

      hour = round_sec / 3600
      rest_sec = round_sec % 3600

      min = rest_sec / 60
      rest_sec = rest_sec % 60

      "#{'%02d' % hour}:#{'%02d' % min}:#{'%02d' % rest_sec}"
    end

    def store
      @config.store
    end

  end
end
