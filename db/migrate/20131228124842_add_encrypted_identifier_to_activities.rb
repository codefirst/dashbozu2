class AddEncryptedIdentifierToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :encrypted_identifier, :string
    add_index :activities, :encrypted_identifier
  end
end
