class CreateDeviceMetrics < ActiveRecord::Migration[7.0]
  def change
    create_table :device_metrics do |t|
      t.references :device, null: false, foreign_key: true
      t.float :temperature
      t.float :air_rh
      t.float :ground_rh
      t.float :luminosity
      t.integer :tank_level
      t.float :volume
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
