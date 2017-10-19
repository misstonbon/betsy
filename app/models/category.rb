class Category < ApplicationRecord
  has_and_belongs_to_many :products

  validates :name, presence: true, uniqueness: true

  # def self.to_category_hash
  #   data = {}
  #   self.each do |cat|
  #     data[cat.name] = cat.products
  #   end
  #   return data
  # end
end
