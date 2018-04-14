class Payment < ApplicationRecord
  belongs_to :client
  belongs_to :buyer
  belongs_to :method, polymorphic: true
end
