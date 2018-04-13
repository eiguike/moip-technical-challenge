class Boleto < ApplicationRecord
  validates_presence_of :number
  validates :number, uniqueness: true
end
