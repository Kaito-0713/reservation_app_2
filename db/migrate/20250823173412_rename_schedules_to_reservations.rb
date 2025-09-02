class RenameSchedulesToReservations < ActiveRecord::Migration[6.1]
  def change
    rename_table :schedules, :reservations_temp
  end
end
