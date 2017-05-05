require 'date'

module ChronoRb
  class Add

    REGEX = '%Y-%m-%d %H:%M:%S'

    def initialize(config:, str_datetime:)
      @config = config
      @str_datetime = str_datetime
    end

    def call
      return @call if defined?(@call)

      @call = error && run
    end

    def run
      klass = if Auto.new(config: @config).call == 'start'
                Start
              else
                Stop
              end

      klass.new(config: @config).call(datetime)
    end

    def error
      !!datetime
    end

    def datetime
      @datetime ||= DateTime.strptime(@str_datetime, REGEX)
    rescue
      false
    end

  end
end
