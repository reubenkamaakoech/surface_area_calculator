class CreateSizes < ActiveRecord::Migration[8.0]
  def change
    create_table :sizes do |t|
      t.string :name
      t.references :product, null: false, foreign_key: true
      t.decimal :buying_price
      t.decimal :selling_price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
