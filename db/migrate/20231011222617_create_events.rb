class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :place
      t.date :date
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
