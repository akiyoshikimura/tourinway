class ChangeDepartureToProducts < ActiveRecord::Migration
  def change
    change_column :products, :departure, :text
  end
end
