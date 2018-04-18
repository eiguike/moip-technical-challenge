class Api::V1::PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    payment = PaymentService.perform(payment_create_params)
    if payment
      render json: payment, status: 201
    else
      render json: {}, status: 400
    end
  end

  def show
    payment = PaymentStatusService.get_status(params)
    if payment
      render json: payment.status, status: 200
    else
      render json: {}, status: 400
    end
  end

  private
  def payment_create_params
    params.fetch(:payment, {}).permit(:amount,
                                      :method_type,
                                      client: [:client_id],
                                      buyer: [:name,
                                              :email,
                                              :CPF],
                                      method: [:holder_name,
                                               :number,
                                               :expiration_date,
                                               :cvv])
  end
end
