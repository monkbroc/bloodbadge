class AddIndexesToUser < ActiveRecord::Migration
  def change
    add_index :users, :username
    add_index :users, :key
  end
end
