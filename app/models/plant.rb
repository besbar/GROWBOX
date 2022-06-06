class Plant < ApplicationRecord
  FAMILY = ["Aglaonema", "Monstera", "Philodendron Scandens", "Pothos", "Zamioculcas Zamiifolia"]
  SITE_NAME = ["Le Wagon", "Jardins de Versailles", "Jardin des Plantes", "Jardin du Luxembourg"]
  SITE_NAME_ADDRESS = ["16 Villa Gaudelet 75011, Paris, France", "Place d'Armes, 78000 Versailles, France", "57 Rue Cuvier, 75005 Paris, France", "Le Jardin du Luxembourg"]

  belongs_to :user
  has_many :plant_devices
  has_many :devices, through: :plant_devices

  geocoded_by :address

  validates :family, presence: true, inclusion: { in: FAMILY }
  validates :species, presence: true
  validates :site_name, presence: true, inclusion: { in: SITE_NAME }
  after_validation :geocode, if: :will_save_change_to_address?
end
