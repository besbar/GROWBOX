class Plant < ApplicationRecord
  FAMILY = ["Aglaonema", "Monstera", "Philodendron Scandens", "Pothos", "Zamioculcas Zamiifolia"]
  SITE_NAME = ["Le Wagon", "Jardins de Versailles", "Jardin des Plantes", "Jardin du Luxembourg"]

  belongs_to :user
  has_many :plant_devices
  has_many :devices, through: :plant_devices

  validates :family, presence: true, inclusion: { in: FAMILY }
  validates :species, presence: true
  validates :site_name, presence: true, inclusion: { in: SITE_NAME }
end
