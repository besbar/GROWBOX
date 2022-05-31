class CreateDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :category
      t.boolean :status, default: false
      t.boolean :temperature, default: false
      t.boolean :air_rh, default: false
      t.boolean :ground_rh, default: false
      t.boolean :luminosity, default: false
      t.boolean :volume, default: false
      t.boolean :tank_level, default: false

      t.timestamps
    end
  end
end
