class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text      :title
      t.text      :destination
      t.integer   :departure
      t.integer   :arrival
      t.text      :detail
      t.integer   :user_id

      t.timestamps
    end
  end
end
