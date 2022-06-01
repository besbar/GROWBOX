class Plant < ApplicationRecord
  belongs_to :user
  has_many :plant_devices
  has_many :devices, through: :plant_devices

  validates :family, presence: true, inclusion: { in: ["Aglaonema", "Monstera", "Philodendron Scandens", "Pothos", "Zamioculcas Zamiifolia"] }
  validates :species, presence: true
  validates :site_name, presence: true
end
