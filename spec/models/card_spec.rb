require 'rails_helper'

RSpec.describe Card, type: :model do
  describe "Validations" do
    it "is not valid when holder_name is empty" do
      card = Card.new(:number => Faker::Number.number(16),
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
      card = Card.new(:number => Faker::Number.number(16),
                      :holder_name=> "João",
                      :cvv => 111)
      expect(card).not_to be_valid
    end
    it "is not valid when cvv is empty" do
      card = Card.new(:number => Faker::Number.number(16),
                      :holder_name=> "João",
                      :expiration_date => Time.now)
      expect(card).not_to be_valid
    end

    it "is not valid when the card already expired" do
      card = Card.new(:number => Faker::Number.number(16),
                      :holder_name=> "João",
                      :expiration_date => Time.now - 1.year,
                      :cvv => 111)
      expect(card).not_to be_valid
    end

    it "is not valid when the card is invalid" do
      card = Card.new(:number => Faker::Number.number(17),
                      :holder_name=> "João",
                      :expiration_date => Time.now - 1.year,
                      :cvv => 111)
      expect(card).not_to be_valid
    end

    it "is not valid when the cvv is invalid (with letters)" do
      card = Card.new(:number => Faker::Number.number(17),
                      :holder_name=> "João",
                      :expiration_date => Time.now - 1.year,
                      :cvv => "asdf")
      expect(card).not_to be_valid
    end

    it "is not valid when the cvv is invalid" do
      card = Card.new(:number => Faker::Number.number(17),
                      :holder_name=> "João",
                      :expiration_date => Time.now - 1.year,
                      :cvv => "1234")
      expect(card).not_to be_valid
    end

    it "is valid when everything is fullfil" do
      card = Card.new(:number => Faker::Number.number(16),
                      :holder_name=> "João",
                      :expiration_date => Time.now + 1.year,
                      :cvv => 111)
      expect(card).to be_valid
    end

    it { should have_many(:payments) }
  end
end
