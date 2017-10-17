class AddForeignKeystoShoppingCart < ActiveRecord::Migration[5.1]
  def change
    add_reference :carts, :product, foreign_keys: true
    add_reference :carts, :user, foreign_keys: true
  end
end
