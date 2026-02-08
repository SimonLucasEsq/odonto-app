class CreateWorkOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :work_orders do |t|
      t.integer :status

      t.timestamps
    end
  end
end
