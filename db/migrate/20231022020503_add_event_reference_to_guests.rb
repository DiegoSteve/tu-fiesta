class AddEventReferenceToGuests < ActiveRecord::Migration[7.0]
  def change
    add_reference :guests, :event, null: false, foreign_key: true
  end
end
