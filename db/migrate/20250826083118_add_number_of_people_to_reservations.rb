class AddNumberOfPeopleToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :number_of_people, :integer, default: 1, null: false
  end
end
