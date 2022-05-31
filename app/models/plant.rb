class Plant < ApplicationRecord
  belongs_to :user
  has_many :plant_devices
  has_many :devices, through: :plant_devices
end
