class CreateSecretKeys < ActiveRecord::Migration
  def change
    create_table :secret_keys do |t|
      t.text :key
      t.integer :user_id

      t.timestamps
    end
  end
end
