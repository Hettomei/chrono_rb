module ChronoRb
  class Delete

    def initialize(config:)
      @config = config
    end

    def call
      @del ||= store.del_last_from_array(group: @config.group)
    end

    def store
      @config.store
    end

  end
end
