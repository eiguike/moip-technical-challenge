class Card < ApplicationRecord
  validates_presence_of :holder_name, :number, :expiration_date, :cvv

  has_many :payments, as: :method
end
