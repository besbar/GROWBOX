class Device < ApplicationRecord
  has_many :device_metrics
  has_many :plant_devices
  has_many :plants, through: :plant_devices
  has_many :alert_settings, foreign_key: :sensor_id
end
