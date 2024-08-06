class CreateOrder < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :amount
      t.decimal :total_price
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
