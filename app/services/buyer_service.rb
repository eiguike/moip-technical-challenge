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
    buyer = Buyer.find_by(CPF: @buyer[:cpf])
    if buyer
      return buyer
    end

    buyer = Buyer.new(name: @buyer[:name],
                      email: @buyer[:email],
                      CPF: @buyer[:cpf])
    if buyer.save
      buyera
    else
      return nil
    end
  end
end
