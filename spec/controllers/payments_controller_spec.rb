require 'rails_helper'

RSpec.describe Api::V1::PaymentsController, type: :controller do
  describe "POST #create for boleto" do
    let(:client) do
      Client.create(id: 1, name: Faker::Company.name)
    end

    let(:buyer) do
      Buyer.create(name: Faker::Name.name,
                   email: Faker::Internet.email,
                   CPF: "111.111.111-22")
    end

    before do
      payments = {
        payment: {
          method_type: "Boleto",
          amount: "123.30",
          client: { client_id: client.id },
          buyer: {
            name: buyer.name,
            email: buyer.email,
            cpf: buyer.CPF
          }
        }
      }
      post :create, params: payments
    end

    it "pays as boleto and returns http success" do
      expect(response).to have_http_status(201)
    end

    it "pays as boleto and return boleto's number" do
      boleto = JSON.parse(response.body)
      expect(boleto["number"].length).to eq 25
      expect(Integer(boleto["number"])).to be_kind_of Integer
    end
  end

  describe "POST #create for card" do
    let(:client) do
      Client.create(id: 1, name: Faker::Company.name)
    end

    let(:buyer) do
      Buyer.create(name: Faker::Name.name,
                   email: Faker::Internet.email,
                   CPF: "111.111.111-22")
    end

    before do
      payments = {
        payment: {
          method_type: "Card",
          amount: "123.30",
          client: { client_id: client.id },
          buyer: {
            name: buyer.name,
            email: buyer.email,
            cpf: buyer.CPF
          },
          method: {
            holder_name: buyer.name,
            number: Faker::Number.number(15),
            expiration_date: Time.now + 1.year,
            cvv: Faker::Number.number(3)
          }
        }
      }
      post :create, params: payments
    end

    it "pays as card and returns http success" do
      expect(response).to have_http_status(201)
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
