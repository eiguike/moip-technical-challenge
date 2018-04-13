class CreateBuyers < ActiveRecord::Migration[5.2]
  def change
    create_table :buyers do |t|
      t.string :name
      t.string :email
      t.string :CPF

      t.timestamps
    end
  end
end
