require 'date'

module ChronoRb
  class Store

    def initialize(pstore)
      @pstore = pstore
    end

    def add(group:, entry:)
      @pstore.transaction do
        @pstore[group] ||= []
        @pstore[group].push(entry)
      end
    end

    def del_last_from_array(group:)
      @pstore.transaction do
        @pstore[group] ||= []
        @pstore[group].pop
      end
    end

    def last(group:)
      @pstore.transaction do
        @pstore[group] ||= []
        @pstore[group].last
      end
    end

    def replace_last_with(group:, entry:)
      @pstore.transaction do
        @pstore[group] ||= []

        newstate = @pstore[group]
        newstate.pop
        newstate.concat([entry])

        @pstore[group] = newstate
      end
    end

    def fetch(key, default)
      @pstore.transaction do
        @pstore.fetch(key, default)
      end
    end

    def roots
      @pstore.transaction do
        @pstore.roots
      end
    end

  end
end
