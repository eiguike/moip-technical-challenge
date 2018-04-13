class CreateBoletos < ActiveRecord::Migration[5.2]
  def change
    create_table :boletos do |t|
      t.string :number

      t.timestamps
    end
  end
end
