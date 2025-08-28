class ChangeUserIdNullOnFacilities < ActiveRecord::Migration[6.1]
  def change
    change_column_null :facilities, :user_id, false
  end
end
