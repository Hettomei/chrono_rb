require 'pstore'
require 'fileutils'
require 'date'
require 'chrono_rb/store'

module ChronoRb
  class Conf

    def group
      @group ||= store.fetch('current_group', default_group)
    end

    def set_group(group)
      @group = group
    end

    def store
      @store ||= Store.new(PStore.new(File.join(path, 'config.pstore')))
    end

    def path
      return @path if defined?(@path)

      path = File.join(Dir.home, '.config', 'chrono_rb')
      FileUtils.mkdir_p(path)

      @path = path
    end

    private

    def default_group
      DateTime.now.strftime("%Y-%m-%d")
    end

  end
end
