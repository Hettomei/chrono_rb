module ChronoRb
  class Edit

    def initialize(config:, seconds:)
      @config = config
      @seconds = seconds
    end

    def call
      return @del_last if defined?(@del_last)

      @del_last ||= store.del_last_from_array(group: @config.group)
      @new_time = @del_last + Rational(@seconds, 86400)
      store.add(group: @config.group, entry: @new_time)
    end

    def new_entry
      call
      @new_time
    end

    def last_entry
      call
      @del_last
    end

    def store
      @config.store
    end

  end
end
