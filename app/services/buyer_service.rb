class BuyerService
  def initialize(obj)
    @buyer = obj
  end

  def self.perform(params)
    new(params).perform
  end

  def perform
    create_buyer
  end

  private
  def create_buyer
    buyer = Buyer.new(name: @buyer[:name],
                      email: @buyer[:email],
                      CPF: @buyer[:cpf])
    if buyer.valid?
      buyer.save
      return buyer
    else
      return nil
    end
  end
end
