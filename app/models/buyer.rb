class Buyer < ApplicationRecord
  validates_presence_of :name, :email, :CPF
  validates :email, :CPF, uniqueness: true

  validates :email, format: { with: /\A^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))\Z/,
                              message: "This e-mail is not following the format: user@compay.com" }
  validates :CPF, format: { with: /\A\d{3}.\d{3}.\d{3}-\d{2}\Z/,
                            message: "CPF follows the format: XXX.XXX.XXX-XX, which X is a digit" }

  has_many :payments

end
