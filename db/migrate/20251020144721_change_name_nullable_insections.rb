class ChangeNameNullableInsections < ActiveRecord::Migration[8.0]
  def change
    change_column_null :sections, :user_id, false
    change_column_null :sections, :room_id, true
  end
end
