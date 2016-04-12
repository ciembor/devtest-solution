class CreateLocationsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :locations, :location_groups do |t|
      t.index [:location_id, :location_group_id], name: 'location_location_group_index'
      t.index [:location_group_id, :location_id], name: 'location_group_location_index'
    end
  end
end
