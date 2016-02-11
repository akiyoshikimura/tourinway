class AddRandToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rand, :string
  end
end
