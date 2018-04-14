class Boleto < ApplicationRecord
  validates_presence_of :number
  validates :number, uniqueness: true

  has_many :payments, as: :method
end
