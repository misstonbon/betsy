class Order < ApplicationRecord

  STATUS = ["completed", "incomplete"]

  belongs_to :user
  belongs_to :cart
  has_many :products

  validates :status, presence: true, inclusion: { in: STATUS, allow_nil: false}
end
