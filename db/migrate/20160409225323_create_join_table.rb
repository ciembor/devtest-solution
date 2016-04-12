class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :countries, :target_groups do |t|
      t.index [:country_id, :target_group_id], name: 'country_target_group_index'
      t.index [:target_group_id, :country_id], name: 'target_group_country_index'
    end
  end
end
