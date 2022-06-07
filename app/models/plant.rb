class Plant < ApplicationRecord
  FAMILY = ["Aglaonema", "Monstera", "Philodendron Scandens", "Pothos", "Zamioculcas Zamiifolia"]

  belongs_to :site
  has_many :plant_devices
  has_many :devices, through: :plant_devices

  validates :family, presence: true, inclusion: { in: FAMILY }
  validates :species, presence: true
  validates :site_id, presence: true
end
