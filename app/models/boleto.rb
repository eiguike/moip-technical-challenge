class Boleto < ApplicationRecord
  validates_presence_of :number
  validates :number, uniqueness: true,
                     format: { with: /\A\d{47}\Z/,
                               message: "Boleto's number should have 47 digits" },
                     length: { is: 47 }

  has_many :payments, as: :method
end
