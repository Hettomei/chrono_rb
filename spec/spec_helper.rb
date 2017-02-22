$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "chrono_rb"

# This way, do not call real abort
# during test. Because too hard to handle
module ChronoRb
  def self.exit_with_error(msg)
    warn(msg)
  end
end

RSpec.configure do |config|

  def silence_stdout
    original_stdout = $stdout
    $stdout = File.open(File::NULL, "w")
    yield
  ensure
    $stdout = original_stdout
  end

  def silence_sterr
    original= $stderr
    $stderr = File.open(File::NULL, "w")
    yield
  ensure
    $stderr = original
  end

end
