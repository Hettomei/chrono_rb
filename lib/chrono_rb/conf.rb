require 'pstore'

module ChronoRb
  class Conf
    def self.load
      conf = self.new
      conf.create
      conf.load
    end

    def create
      path = File.join(Dir.home, '.config', 'chrono_rb', 'config')
      # PStore.new(path)
      p "create"
    end

    def load
      "load"
    end

  end
end
