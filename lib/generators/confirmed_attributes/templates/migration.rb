class CreateConfirmedAttributesTables < ActiveRecord::Migration
  def self.up
    create_table :confirmed_attributes_controls do |t|
      t.string :name, null: false, limit: 64
      t.text :value, null: false
      t.references :targetable, polymorphic: true, null: false
      t.references :user

      t.timestamps
    end

    add_index :confirmed_attributes_controls, :name
    add_index :confirmed_attributes_controls, :user_id
    add_index :confirmed_attributes_controls, :targetable_id
    add_index :confirmed_attributes_controls, :targetable_type
  end

  def self.down
    drop_table :confirmed_attributes
  end
end