class ChangeArrivalToProducts < ActiveRecord::Migration
  def change
    change_column :products, :arrival, :text
  end
end
