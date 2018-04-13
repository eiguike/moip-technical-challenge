class Buyer < ApplicationRecord
  validates_presence_of :name, :email, :CPF
  validates :email, :CPF, uniqueness: true
end
