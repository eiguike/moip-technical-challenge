class Api::V1::PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    payment = PaymentService.perform(payment_create_params)
    if payment
      if payment.method_type == "Boleto"
        render json: payment.method, status: 201
      else
        render json: payment, status: 201
      end
    else
      render json: {}, status: 400
    end
  end

  def show
    payment = PaymentService.get_status(payment_show_params)
    if payment
      render json: payment, status: 200
    else
      render json: {}, status: 400
  end

  private
  def payment_create_params
    params.fetch(:payment, {}).permit(:amount,
                                      :method_type,
                                      client: [:client_id],
                                      buyer: [:name,
                                              :email,
                                              :cpf],
                                      method: [:holder_name,
                                               :number,
                                               :expiration_date,
                                               :cvv])
  end

  def payment_show_params
    params.require(:payment, {}).permit(:id)
  end
end