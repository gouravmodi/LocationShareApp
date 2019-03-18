class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    unless table_exists?(:locations)
      create_table :locations do |t|
        t.decimal :latitude
        t.decimal :longitude
        t.string :name
        t.timestamps
      end
    end
  end
end