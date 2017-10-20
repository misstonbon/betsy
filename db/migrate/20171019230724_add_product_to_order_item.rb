class AddProductToOrderItem < ActiveRecord::Migration[5.1]
  def change
    add_reference :order_items, :product, foreign_keys: true
  end
end
