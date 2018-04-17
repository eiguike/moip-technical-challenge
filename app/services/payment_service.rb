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
    create_payment
  end

  def self.get_status(params)
    new(params).get_status
  end

  def get_status
    get_payment
  end

  private

  attr_reader :payment_amount,:payment_method, :client, :buyer, :method

  def get_status
    return nil
  end

  def create_payment_method
    if @payment_method == "Boleto"
      Boleto.create(number: Faker::Number.number(25))
    elsif @payment_method == "Card"
      Card.create(@method)
    end
  end

  def create_payment
    client = Client.find_by(id: @client[:client_id])
    return if client.nil?

    buyer = BuyerService.perform(@buyer)
    return if buyer.nil?

    method = create_payment_method
    return if method.nil?
    payment = Payment.create(method: method,
                             buyer: buyer,
                             amount: @payment_amount,
                             client: client)

    if payment.method_type == "Boleto"
      return payment.method
    end
    return payment
  end
end
