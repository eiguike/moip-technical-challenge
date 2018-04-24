class Card < ApplicationRecord
  validates_presence_of :holder_name, :number, :expiration_date, :cvv

  validates :number, format: { with: /\A\d{16}\Z/,
                               message: "Card's number should have 16 digits"}
  validates :cvv, format: { with: /\A\d{3}\Z/,
                            message: "CVV should have 3 digits"}
  validate :check_expiration_date

  has_many :payments, as: :method

  def check_expiration_date
    return true unless expiration_date != nil
    if Time.now > expiration_date
      errors.add(:expiration_date, "Card already expired")
    end
  end
end
