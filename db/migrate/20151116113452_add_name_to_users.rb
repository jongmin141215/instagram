class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, null: false, unique: true
  end
end
