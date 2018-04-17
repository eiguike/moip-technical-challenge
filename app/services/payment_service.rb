class PaymentService
  def initialize(params)
    if params.key? :method_type
      @payment_method = params[:method_type]
    end
    if params.key? :amount
      @payment_amount = params[:amount]
    end
    if params.key? :client
      @client = params[:client]
    end
    if params.key? :buyer
      @buyer = params[:buyer]
    end
    if params.key? :method
      @method = params[:method]
    end
    if params.key? :id
      @payment_id = params[:id]
    end
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
    get_payment_status
  end

  private

  attr_reader :payment_amount,:payment_method, :client, :buyer, :method

  def get_payment_status
    Payment.find_by(id: @payment_id)
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
