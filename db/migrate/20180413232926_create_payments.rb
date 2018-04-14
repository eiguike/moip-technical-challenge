class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.float :amount
      t.references :client, foreign_key: true
      t.references :buyer, foreign_key: true
      t.string :method_type
      t.integer :method_id

      t.timestamps
    end
  end
end
