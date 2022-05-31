class AlertSetting < ApplicationRecord
  belongs_to :sensor, class_name: "Device"
end
