require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe "Validations" do
    it "is not valid when amount is empty" do
      client = Client.create(:name => Faker::Company.name)
      buyer = Buyer.create(:name => Faker::Name.name, :email => Faker::Internet.email, :CPF => "111.111.111-11")
      boleto = Boleto.create(:number => Faker::Number.number(25))

      payment = Payment.new(:client => client,
                            :buyer => buyer,
                            :method => boleto,
                            :status => "success")
      expect(payment).to_not be_valid
    end

    it "is not valid when client is empty" do
      buyer = Buyer.create(:name => Faker::Name.name, :email => Faker::Internet.email, :CPF => "111.111.111-11")
      boleto = Boleto.create(:number => Faker::Number.number(25))

      payment = Payment.new(:amount => Faker::Number.decimal(2),
                            :buyer => buyer,
                            :method => boleto,
                            :status => "success")
      expect(payment).to_not be_valid
    end

    it "is not valid when buyer is empty" do
      client = Client.create(:name => Faker::Company.name)
      boleto = Boleto.create(:number => Faker::Number.number(25))

      payment = Payment.new(:amount => Faker::Number.decimal(2),
                            :client => client,
                            :method => boleto,
                            :status => "success")
      expect(payment).to_not be_valid
    end

    it "is not valid when method is empty" do
      buyer = Buyer.create(:name => Faker::Name.name, :email => Faker::Internet.email, :CPF => "111.111.111-11")
      client = Client.create(:name => Faker::Company.name)

      payment = Payment.new(:amount => Faker::Number.decimal(2),
                            :buyer => buyer,
                            :client => client,
                            :status => "success")
      expect(payment).to_not be_valid
    end

    it "is not valid when status is empty" do
      buyer = Buyer.create(:name => Faker::Name.name, :email => Faker::Internet.email, :CPF => "111.111.111-11")
      client = Client.create(:name => Faker::Company.name)
      boleto = Boleto.create(:number => Faker::Number.number(25))

      payment = Payment.new(:amount => Faker::Number.decimal(2),
                            :buyer => buyer,
                            :method => boleto,
                            :client => client)
      expect(payment).to_not be_valid
    end

    it "is valid when has everything and it is for boleto" do
      buyer = Buyer.create(:name => Faker::Name.name, :email => Faker::Internet.email, :CPF => "111.111.111-11")
      client = Client.create(:name => Faker::Company.name)
      boleto = Boleto.create(:number => Faker::Number.number(25))

      payment = Payment.new(:amount => Faker::Number.decimal(2),
                            :buyer => buyer,
                            :client => client,
                            :method => boleto,
                            :status => "success")
      expect(payment).to be_valid
    end

    it "is valid when has everything and it is for card" do
      buyer = Buyer.create(:name => Faker::Name.name, :email => Faker::Internet.email, :CPF => "111.111.111-11")
      client = Client.create(:name => Faker::Company.name)
      card = Card.create(:holder_name => Faker::Name.name,
                         :number => Faker::Number.number(15),
                         :expiration_date => Time.now + 1.year,
                         :cvv => Faker::Number.number(3))

      payment = Payment.new(:amount => Faker::Number.decimal(2),
                            :buyer => buyer,
                            :client => client,
                            :method => card,
                            :status => "success")
      expect(payment).to be_valid
    end

  end
end
