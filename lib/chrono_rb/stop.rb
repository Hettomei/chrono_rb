require 'date'

module ChronoRb
  class Stop

    def initialize(config:)
      @config = config
    end

    def call(entry = nil)
      last = store.last(group: @config.group)
      raise "Cannot stop if not start" unless last
      raise "Cannot stop if already stopped" if last.size > 1

      new_date = entry || DateTime.now
      result = [last.first, new_date]

      store.del_last_from_array(group: @config.group)
      store.add(group: @config.group, entry: result)
    end

    def store
      @config.store
    end

  end
end
