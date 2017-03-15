require 'date'

module ChronoRb
  class Start

    def initialize(config:)
      @config = config
    end

    def start(entry = nil)
      last = store.last(group: @config.group)
      raise "Cannot start if ongoing" if last && last.size == 1

      store.add(group: @config.group, entry: [entry || DateTime.now])
    end

    def store
      @config.store
    end

  end
end
