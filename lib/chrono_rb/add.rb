require 'date'

module ChronoRb
  class Add

    REGEX = '%Y-%m-%d %H:%M:%S %z'

    def initialize(config:, str_datetime:)
      @config = config
      @str_datetime = str_datetime
    end

    def call
      return @call if defined?(@call)

      @call = error && run
    end

    def run
      StartStop.new(config: @config).call(datetime)
    end

    def error
      !!datetime
    end

    def datetime
      @datetime ||= DateTime.strptime(str_datetime_with_timezone, REGEX)
    rescue
      false
    end

    def str_datetime_with_timezone
      "#{@str_datetime} #{DateTime.now.zone}"
    end

    def get_error
      "Cannot parse #{str_datetime_with_timezone} with #{REGEX}"
    end

  end
end
