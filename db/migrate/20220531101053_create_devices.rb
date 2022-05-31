class CreateDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :category
      t.boolean :status
      t.boolean :temperature
      t.boolean :air_rh
      t.boolean :ground_rh
      t.boolean :luminosity
      t.boolean :volume
      t.boolean :tank_level

      t.timestamps
    end
  end
end
