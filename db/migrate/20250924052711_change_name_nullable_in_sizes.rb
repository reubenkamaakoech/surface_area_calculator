class ChangeNameNullableInSizes < ActiveRecord::Migration[8.0]
  def change
     change_column_null :sizes, :name, false
  end
end
