require 'date'

module ChronoRb
  class Start

    def initialize(config:)
      @config = config
    end

    def start
      store.add(group: @config.group, entry: DateTime.now)
    end

    def entries
      store.fetch(@config.group, [])
    end

    def store
      @config.store
    end

  end
end
