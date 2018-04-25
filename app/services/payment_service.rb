class PaymentService
  def initialize(params)
    @payment_method = params[:method_type]
    @payment_amount = params[:amount]
    @client = params[:client]
    @buyer = params[:buyer]
    @method = params[:method]
  end

  def self.perform(params)
    new(params).perform
  end

  def perform
    return unless valid?
    create_payment
  end

  private
  attr_reader :payment_amount,:payment_method, :client, :buyer, :method

  def valid?
    @payment_method && @payment_amount && @client && @buyer
  end

  def create_payment_method
    if @payment_method == "Boleto"
      Boleto.create(number: Faker::Number.number(47))
    elsif @payment_method == "Card"
      Card.where(@method).find_or_create_by(@method)
    end
  end

  def create_payment
    ActiveRecord::Base.transaction do
      client = Client.find_by(id: @client[:client_id])
      return unless client != nil
      buyer = Buyer.where(@buyer).find_or_create_by(@buyer)
      method = create_payment_method

      # mocking results
      status = "success"
      if payment_method == "Card"
        if rand > 0.94
          status = "fail"
        end
      end

      payment = Payment.create(method: method,
                               buyer: buyer,
                               amount: @payment_amount,
                               client: client,
                               status: status)
      if payment.method_type == "Boleto"
        return { "id": payment.id, "number": method.number }
      end
      return { "id": payment.id, "status": payment.status }
    end
  end
end
