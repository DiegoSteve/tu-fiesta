class CreateGuests < ActiveRecord::Migration[7.0]
  def change
    create_table :guests do |t|
      t.string :name
      t.string :email
      t.string :telephone
      t.string :kinship
      t.integer :table

      t.timestamps
    end
  end
end
