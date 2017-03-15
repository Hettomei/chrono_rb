module ChronoRb
  class Auto

    def initialize(config:)
      @config = config
    end

    def auto(entry = nil)
      last = store.last(group: @config.group)
      if last.nil? || last.size > 1
        'start'
      else
        'stop'
      end
    end

    def store
      @config.store
    end

  end
end
