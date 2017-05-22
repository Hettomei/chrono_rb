module ChronoRb
  class Groups

    def initialize(config:)
      @config = config
    end

    def all
      store.groups.sort
    end

    def call
      biggest = 0
      array = []

      all.map do |group|
        biggest = group.size if group.size > biggest
        entries_count = store.fetch(group, []).count

        array << [group, entries_count]
      end

      array.each do |name, size|
        puts "#{name.ljust(biggest)} : #{size}"
      end
    end

    def store
      @config.store
    end

  end
end
