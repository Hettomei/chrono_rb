module ChronoRb
  class Entries

    def initialize(config:)
      @config = config
    end

    def display
      total = 0
      store.fetch(@config.group, []).each do |array|
        if array.length == 1
          puts format(array.first)
        else
          total += array[2]
          puts "#{format(array.first)} -> #{format(array[1])} : #{format_sec_to_duration(array[2])}"
        end
      end

      puts "Total : #{format_sec_to_duration(total)}"
    end

    def format(date)
      date.strftime("%Y-%m-%d %T")
    end

    def format_sec_to_duration(sec)

      if sec >= 3600*24
        time = Time.at(sec % (3600 * 24)).utc.strftime('%T')
        d = sec.round / (3600 * 24)
        "#{d} days #{time}"
      else
        Time.at(sec).utc.strftime('%T')
      end
    end

    def store
      @config.store
    end

  end
end
