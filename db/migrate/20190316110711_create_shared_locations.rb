class CreateSharedLocations < ActiveRecord::Migration[5.0]
  def change
    unless table_exists?(:shared_locations)
      create_table :shared_locations do |t|
        t.integer :shared_by_id
        t.integer :shared_with_id
        t.references :location
        t.timestamps
      end
      add_index :shared_locations, :shared_by_id, :name => "shared_by_id_idx"
      add_index :shared_locations, :shared_with_id, :name => "shared_with_id_idx"
      add_index :shared_locations, :location_id, :name => "location_id_idx"
    end
  end
end
