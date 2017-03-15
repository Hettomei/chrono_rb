module ChronoRb
  class Entries

    ONE_DAY_IN_SEC = 3600 * 24

    def initialize(config:)
      @config = config
    end

    def display
      total = 0
      store.fetch(@config.group, []).each do |array|
        if array.length == 1
          puts format(array.first)
        else
          diff_in_seconds = array[1].to_time - array[0].to_time
          total += diff_in_seconds
          puts "#{format(array[0])} -> #{format(array[1])} : #{format_sec_to_duration(diff_in_seconds)}"
        end
      end

      puts "Total: #{format_sec_to_duration(total)}"
    end

    def format(date)
      date.strftime("%Y-%m-%d %T")
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
