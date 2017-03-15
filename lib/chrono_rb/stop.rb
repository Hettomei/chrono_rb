require 'date'

module ChronoRb
  class Stop

    def initialize(config:)
      @config = config
    end

    def call(aa = nil)
      last = store.last(group: @config.group)
      raise "Cannot stop if not start" unless last
      raise "Cannot stop if already stopped" if last.size > 1

      new_date = aa || DateTime.now
      entry = [last.first, new_date]
      store.del_last_from_array(group: @config.group)
      store.add(group: @config.group, entry: entry)
    end

    def store
      @config.store
    end

  end
end
