class Product < ApplicationRecord
  has_many :reviews
  belongs_to :user

  validates :name, presence: true, uniqueness: true, allow_nil: false
  validates :category, presence: true, allow_nil: false
  validates :price, :presence => true,
            :numericality => true,
            :format => { :with => /^\d{1,4}(\.\d{0,2})?$/, multiline: true }
  validates :quantity, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

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
