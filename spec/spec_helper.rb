$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

require 'bundler/setup'
require 'confirmed_attributes'
# require "sqlite3"
# require "activerecord"

Bundler.setup

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
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

  create_table :users do |t|
    t.string :name
    t.string :email
  end
end

RSpec.configure do |config|
end

class User < ActiveRecord::Base
  confirmable_attribute :email
end

def clean_database
  models = [ConfirmedAttributes::Control]
  models.each do |model|
    ActiveRecord::Base.connection.execute "DELETE FROM #{model.table_name}"
  end
end