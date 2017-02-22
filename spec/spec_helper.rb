$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "chrono_rb"

# This way, do not call real abort
# during test. Because too hard to handle
#
# Without this, If my code call exit_with_error
# every other tests are skipped, and classic
# rspec trace is printed.
#
# That mean, If I had 333 total test to do
# but it fail on 330th test
# Nothing will tel me that is something wrong
#
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
