require 'rails_helper'

RSpec.describe Card, type: :model do
  describe "Validations" do
    it "is not valid when holder_name is empty" do
      card = Card.new(:number => "49295463632986724485835022353606448544825998158445327957980420934539500792751423",
                      :expiration_date => Time.now,
                      :cvv => 111)
      expect(card).not_to be_valid
    end
    it "is not valid when number is empty" do
      card = Card.new(:holder_name=> "João",
                      :expiration_date => Time.now,
                      :cvv => 111)
      expect(card).not_to be_valid
    end
    it "is not valid when expiration_date is empty" do
      card = Card.new(:number => "49295463632986724485835022353606448544825998158445327957980420934539500792751423",
                      :holder_name=> "João",
                      :cvv => 111)
      expect(card).not_to be_valid
    end
    it "is not valid when cvv is empty" do
      card = Card.new(:number => "49295463632986724485835022353606448544825998158445327957980420934539500792751423",
                      :holder_name=> "João",
                      :expiration_date => Time.now)
      expect(card).not_to be_valid
    end
  end
end
