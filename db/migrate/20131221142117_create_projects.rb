class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :api_key, null: false

      t.timestamps
    end
    add_index :projects, :api_key, unique: true
  end
end
