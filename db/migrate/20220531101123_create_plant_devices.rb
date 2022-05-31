class CreatePlantDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :plant_devices do |t|
      t.references :plant, null: false, foreign_key: true
      t.references :device, null: false, foreign_key: true

      t.timestamps
    end
  end
end
