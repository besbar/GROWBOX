class AlertSetting < ApplicationRecord
  belongs_to :sensor, class_name: "Device"

  validates :tank_level_min, inclusion: { in: [0, 1] }, allow_nil: true

  validates :ground_rh_min, numericality: { greater_than_or_equal: 0 }, allow_nil: true
  validates :ground_rh_max, numericality: { greater_than: :ground_rh_min }, allow_nil: true

  validates :luminosity_min, numericality: { greater_than_or_equal: 0 }, allow_nil: true
  validates :luminosity_max, numericality: { greater_than: :luminosity_min }, allow_nil: true

  validates :air_rh_min, numericality: { greater_than_or_equal: 0 }, allow_nil: true
  validates :air_rh_max, numericality: { greater_than: :air_rh_min }, allow_nil: true

  validate :at_least_one_threshold

  private

  def at_least_one_threshold
    fields = [tank_level_min, ground_rh_min, ground_rh_max, luminosity_min, luminosity_max, air_rh_min, air_rh_max]
    errors.add(:base, "Doit contenir au moins un palier") if fields.all?(&:nil?)
  end
end
