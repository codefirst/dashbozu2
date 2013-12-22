class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :title
      t.text :body
      t.string :source
      t.integer :project_id
      t.string :url
      t.string :icon_url
      t.string :status
      t.string :author

      t.timestamps
    end
  end
end
