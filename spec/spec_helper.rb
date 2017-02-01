$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "chrono_rb"

# This way, do not call real abort
# during test. Because too hard to handle
module ChronoRb
  def self.exit_with_error(msg)
    warn(msg)
  end
end
