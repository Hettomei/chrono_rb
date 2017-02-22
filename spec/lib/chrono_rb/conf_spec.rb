require "spec_helper"

describe ChronoRb::Conf do

  describe "#create" do
    context "no conf exist" do
      it "display init" do
        expect{
          ChronoRb::Conf.new.create
        }.to output(/create/).to_stdout
      end
    end
  end

end
