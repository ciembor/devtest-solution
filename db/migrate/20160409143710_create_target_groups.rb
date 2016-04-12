class CreateTargetGroups < ActiveRecord::Migration
  def change
    create_table :target_groups do |t|
      t.string :name
      t.string :secret_code
      t.integer :external_id
      t.integer :parent_id
      t.integer :panel_provider_id

      t.timestamps null: false
    end
  end
end
