require "spec_helper"

describe ChronoRb::CLI do

  it "has a start command" do
    expect {ChronoRb::CLI.start(%w(start))}.to output(/ok/).to_stdout
  end

end
