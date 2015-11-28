class AddStatusColumnToCart < ActiveRecord::Migration
  def change
    add_column :carts, :status, :boolean
  end
end
