class PaymentStatusService
  def initialize(params)
    @payment_id = params[:id]
  end

  def self.get_status(params)
    new(params).get_status
  end

  def get_status
    return unless valid?
    get_payment_status
  end

  private
  attr_reader :payment_id

  def valid?
    @payment_id
  end

  def get_payment_status
    payment = Payment.find_by(id: @payment_id)
    return nil unless payment != nil

    payment_json = payment.slice(:id, :amount, :method_type, :status)
    payment_json[:client] = payment.client.slice(:id)
    payment_json[:buyer] = payment.buyer.slice(:name, :email, :CPF)

    if (payment.method_type == "Card")
      payment_json[:method] = payment.method.slice(:holder_name, :number, :expiration_date, :cvv)
    end
    return payment_json
  end
end
