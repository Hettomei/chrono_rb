module ChronoRb
  class Stop

    def initialize(config:)
      @config = config
    end

    def stop
      last = store.last(group: @config.group)
      raise "Cannot stop if not start" unless last
      raise "Cannot stop if already stopped" if last.size > 1

      new_date = DateTime.now
      diff_in_seconds = new_date.to_time - last.first.to_time
      entry = [last.first, new_date, diff_in_seconds]
      store.replace_last_with(group: @config.group, entry: entry)
    end

    def store
      @config.store
    end

  end
end
