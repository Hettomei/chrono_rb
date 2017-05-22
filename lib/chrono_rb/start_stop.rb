require 'date'

module ChronoRb
  class StartStop

    def initialize(config:)
      @config = config
    end

    def call(entry = nil)
      store.add(group: @config.group, entry: entry || DateTime.now)
    end

    def store
      @config.store
    end

  end
end
