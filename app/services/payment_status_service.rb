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
    Payment.find_by(id: @payment_id)
  end
end
