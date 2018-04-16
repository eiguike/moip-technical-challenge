require 'rails_helper'

RSpec.describe Api::V1::PaymentsController, type: :controller do
  describe "POST #create" do
    it "returns http success" do
      buyer = Buyer.create(:name => Faker::Name.name,
                           :CPF => "111.111.111-11",
                           :email => Faker::Internet.email)
      client = Client.create(:name => Faker::Company.name)
      card = Card.create(:holder_name => buyer.name,
                         :number => Faker::Number.number(15),
                         :expiration_date => Time.now + 1.year,
                         :cvv => Faker::Number.number(3))
      post :create
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: {:id => 1}
      ## expect(response.status).to eq 200
      expect(response).to have_http_status(200)
    end
  end
end
