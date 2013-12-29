require "spec_helper"

describe OrderNotifierMailer do
  describe "notifier" do
    let(:mail) { OrderNotifierMailer.notifier }

    it "renders the headers" do
      mail.subject.should eq("Notifier")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "confirmation" do
    let(:mail) { OrderNotifierMailer.confirmation }

    it "renders the headers" do
      mail.subject.should eq("Confirmation")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
