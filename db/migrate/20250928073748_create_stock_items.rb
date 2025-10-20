class CreateStockItems < ActiveRecord::Migration[8.0]
  def change
    create_table :stock_items do |t|
      t.references :stock, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :size, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
