class Order < ApplicationRecord

  STATUS = ["pending", "paid"]

  belongs_to :user
  belongs_to :cart
  has_many :products

  validates :status, presence: true, inclusion: { in: STATUS, allow_nil: false}
end
