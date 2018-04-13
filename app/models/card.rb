class Card < ApplicationRecord
  validates_presence_of :holder_name, :number, :expiration_date, :cvv
end
