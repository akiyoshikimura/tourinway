class AddProductIdToMaps < ActiveRecord::Migration
  def change
    add_column :maps, :product_id, :integer
  end
end
