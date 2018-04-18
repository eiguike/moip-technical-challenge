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
      Boleto.create(number: Faker::Number.number(25))
    elsif @payment_method == "Card"
      Card.where(@method).first_or_create
    end
  end

  def create_payment
    ActiveRecord::Base.transaction do
      client = Client.where(id: @client[:client_id]).first_or_create(name: Faker::Company.name)
      buyer = Buyer.where(@buyer).first_or_create
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
        return payment.method
      end
      return payment
    end
  end
end
