require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe "Validations" do
    it "is not valid when amount is empty" do
      client = Client.create(:name => Faker::Company.name)
      buyer = Buyer.create(:name => Faker::Name.name, :email => Faker::Internet.email, :CPF => "111.111.111-11")
      boleto = Boleto.create(:number => Faker::Number.number(25))

      payment = Payment.new(:client => client, :buyer => buyer, :method => boleto)
      expect(payment).to_not be_valid
    end
  end
end
