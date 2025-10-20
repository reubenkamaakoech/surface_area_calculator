class ChangeNameNullableInproducts < ActiveRecord::Migration[8.0]
  def change
     change_column_null :products, :name, false
  end
end
