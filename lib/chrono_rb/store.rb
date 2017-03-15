require 'date'
require 'chrono_rb/conf'

module ChronoRb
  class Store

    def initialize(pstore)
      @pstore = pstore
    end

    def set_group(name)
      @pstore.transaction do
        @pstore[Conf::KEY_GROUPS] = name
      end
    end

    def unset_group
      @pstore.transaction do
        @pstore.delete(Conf::KEY_GROUPS)
      end
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

    def fetch(key, default)
      @pstore.transaction(true) do
        @pstore.fetch(key, default)
      end
    end

    def groups
      @pstore.transaction(true) do
        @pstore.roots.select { |key| key != Conf::KEY_GROUPS}
      end
    end

  end
end
