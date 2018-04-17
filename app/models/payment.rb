class Payment < ApplicationRecord
  belongs_to :client
  belongs_to :buyer
  belongs_to :method, polymorphic: true

  validates :status,
    format: {with: /(^success$|^fail$|^$)/,
    message: "only allow 'success' or 'fail'"},
    presence: true
  validates_presence_of :amount
end
