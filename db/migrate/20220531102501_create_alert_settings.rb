class CreateAlertSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :alert_settings do |t|
      t.text :description
      t.references :sensor, null: false, foreign_key: { to_table: :devices }
      t.float :temperature_min
      t.float :temperature_max
      t.integer :tank_level_min
      t.float :ground_rh_min
      t.float :ground_rh_max
      t.float :luminosity_min
      t.float :luminosity_max

      t.timestamps
    end
  end
end
