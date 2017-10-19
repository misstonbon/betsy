class Product < ApplicationRecord
  has_many :reviews
  belongs_to :user

  has_and_belongs_to_many :categories
  validates :name, presence: true
  validates_uniqueness_of :name, scope: [:category]
  validates :category, presence: true, allow_nil: false
  validates :price, presence: true, numericality: true,
            :format => { :with => /^\d{1,4}(\.\d{0,2})?$/, multiline: true }
  validates :quantity, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  CATEGORIES = ["food", "cosmetics", "clothing"]

  def self.to_category_hash
    data = {}
    CATEGORIES.each do |cat|
      data[cat] = by_category(cat)
    end
    return data
  end

  # def self.to_merchant_hash
  #   data = {}
  #   merchants_with_products= (User.all).where(user.products.count > 0 )
  #
  #   merchants_with_products.each do |merchant|
  #     data[merchant] = by_merchant(merchant)
  #   end
  #
  #   return data
  #
  # end

  def self.by_category(category)
    return self.where(category: category)
  end

  def self.by_merchant(merchant)
    return self.where(user: merchant)
  end

  # def order_by_ratings(products)
  #   products.order(avg_rating: avg_rating(product)).limit(10)
  # end

  # def avg_rating(product)
  #   if (product.reviews).count > 0
  #     sum_ratings = (product.reviews).reduce(:+)
  #     avg = sum_ratings/(product.reviews.count)
  #     return avg
  #   else
  #     return nil
  #   end
  # end

end
