class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :provider
      t.integer :uid
      t.string :name
      t.string :nickname
      t.string :image
      t.string :token
      t.integer :parent_user_id

      t.timestamps
    end

    add_index :users, :provider
    add_index :users, :nickname
  end
end
