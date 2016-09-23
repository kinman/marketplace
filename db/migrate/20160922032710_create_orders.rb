class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :item_name, null: false
      t.references :customer
      
      t.timestamps
    end
    add_index :orders, :customer_id, name: 'dnx_customers'
  end
end
