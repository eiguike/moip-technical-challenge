require 'rails_helper'

RSpec.describe Client, type: :model do
  describe "Validations" do
    it "is not valid when name is empty" do
      client = Client.new
      expect(client).to_not be_valid
    end

    it { should have_many(:payments) }
  end
end
