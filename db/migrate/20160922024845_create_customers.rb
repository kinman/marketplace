class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name

      t.timestamps
    end
    add_index :customers, :name, name: 'unx_customers'
    
  end
end
