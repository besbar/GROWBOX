class Device < ApplicationRecord
  CATEGORY = ["capteur", "actionneur", "caméra"]
  SUBCATEGORY = ["capteur", "environnement", "humidité sol", "débitmètre", "luminosité", "réservoir", "arrosage", "caméra"]
  SUBCATEGORYB = { "capteur" => ["environnement", "humidité sol", "débitmètre", "luminosité", "réservoir"], "actionneur" => "arrosage", "caméra" => "caméra" }

  belongs_to :user
  has_many :device_metrics
  has_many :plant_devices
  has_many :plants, through: :plant_devices
  has_many :alert_settings, foreign_key: :sensor_id

  validates :name, presence: true
  validates :category, inclusion: { in: CATEGORY }
  validates :subcategory, inclusion: { in: SUBCATEGORY }
end
