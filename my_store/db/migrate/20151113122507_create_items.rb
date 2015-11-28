class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
			t.string :name
      t.float  :price
      t.string :description	
      t.timestamps null: false
    end
    add_index :items, :name
    add_index :items, :price
  end
end
