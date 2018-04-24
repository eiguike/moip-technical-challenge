require 'rails_helper'

RSpec.describe Buyer, type: :model do
  describe "Validation" do
    it "is not valid when name is empty" do
      buyer = Buyer.new(:email => "teste@gmail.com", :CPF => "111.111.111-11")
      expect(buyer).to_not be_valid
    end
    it "is not valid when email is empty" do
      buyer = Buyer.new(:name => "João", :CPF => "111.111.111-11")
      expect(buyer).to_not be_valid
    end
    it "is not valid when the email registered already exists" do
      buyer = Buyer.create(:name => "João", :email => "teste@gmail.com", :CPF => "111.111.111-11")
      buyer = Buyer.create(:name => "João", :email => "teste@gmail.com", :CPF => "222.222.222-22")
      expect(buyer).to_not be_valid
    end
    it "is not valid when CPF is empty" do
      buyer = Buyer.new(:name => "João", :email => "teste@gmail.com")
      expect(buyer).to_not be_valid
    end
    it "is not valid when the CPF registered already exists" do
      buyer = Buyer.create(:name => "João", :email => "teste@gmail.com", :CPF => "111.111.111-11")
      buyer = Buyer.new(:name => "João", :email => "teste2@gmail.com", :CPF => "111.111.111-11")
      expect(buyer).to_not be_valid
    end

    it "is not valid when the email does not follow the correct format" do
      buyer = Buyer.new(:name => "João", :email => "testegmail.com", :CPF => "111.111.111-11")
      expect(buyer).to_not be_valid
    end

    it "is not valid when the CPF does not follow the correct format" do
      buyer = Buyer.new(:name => "João", :email => "testegmail.com", :CPF => "111.111.111-aa")
      expect(buyer).to_not be_valid
    end

    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:CPF) }
    it { should validate_presence_of(:name) }
  end
end
