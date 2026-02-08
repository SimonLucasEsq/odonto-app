class CreateWorkOrderItems < ActiveRecord::Migration[8.1]
  def change
    create_table :work_order_items do |t|
      t.references :work_order, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
