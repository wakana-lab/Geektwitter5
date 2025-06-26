class AddShopRefToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :shop, null: true, foreign_key: true
  end
end
