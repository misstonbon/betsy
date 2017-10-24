class Category < ApplicationRecord
  has_and_belongs_to_many :products

  validates :name, presence: true, uniqueness: true

  # def self.all_categories
  #   @categories_list = []
  #   @categories.each do |cat|
  #     @categories_list << cat.name
  #   end
  #
  #   return @categories_list
  # end
end
