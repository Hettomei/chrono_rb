require "spec_helper"

describe ChronoRb::CLI do

  describe "#start" do
    context "first start" do
      let(:group){ DateTime.now.strftime("%Y-%m-%d") }

      it "display init" do
        expect{
          ChronoRb::CLI.start(%w(start))
        }.to output(/starting chrono for group #{group}/).to_stdout
      end
    end

    context "start next after another start" do
      let(:group){ DateTime.now.strftime("%Y-%m-%d") }

      xit "exit with code > 0" do
        expect{
          ChronoRb::CLI.start(%w(start))
        }.to output(/Error/).to_stderr
      end

    end
  end

  describe "#stop" do
    context "never started" do
      let(:group){ DateTime.now.strftime("%Y-%m-%d") }

      it "exit with code > 0" do
        expect {
          ChronoRb::CLI.start(%w(stop))
        }.to output(/Error chrono must be started for group #{group}/).to_stderr
      end

    end
  end

end
