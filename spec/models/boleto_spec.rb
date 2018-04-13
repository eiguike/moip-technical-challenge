require 'rails_helper'

RSpec.describe Boleto, type: :model do
  describe "Validations" do
    it "is not valid when number is empty" do
      boleto = Boleto.new
      expect(boleto).to_not be_valid
    end
    it "is not valid when the boleto's number is already registered" do
      boleto = Boleto.create(:number => "00190000090302122300737724708179780700000111360")
      boleto = Boleto.new(:number => "00190000090302122300737724708179780700000111360")
      expect(boleto).to_not be_valid
    end
  end
end
