# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "open-uri"
require "nokogiri"
require 'csv'

DeviceMetric.destroy_all
PlantDevice.destroy_all
Device.destroy_all
Plant.destroy_all
User.destroy_all

#Create one user
user = User.new(
  first_name: "nolan",
  last_name: "vandamme",
  company: "akagreen",
  email:"nolan.vandamme@gmail.com",
  password:"1234567",
  admin: true
)
user.save
puts "users created"

# Seed of devices
# 22 devices ow some are false (currently not used/active)

device_1 = Device.create!(
  name: "environnement #1",
  category: "capteur",
  subcategory: "environnement",
  status: true,
  temperature: true,
  air_rh: true,
  ground_rh: false,
  luminosity: false,
  volume: false,
  tank_level: false,
  user: user
)

device_2 = Device.create!(
  name: "humidité sol #1",
  category: "capteur",
  subcategory: "humidité sol",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: true,
  luminosity: false,
  volume: false,
  tank_level: false,
  user: user
)

device_3 = Device.create!(
  name: "réservoir #1",
  category: "capteur",
  subcategory: "réservoir",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: false,
  volume: false,
  tank_level: true,
  user: user
)

device_4 = Device.create!(
  name: "débitmètre #1",
  category: "capteur",
  subcategory: "débitmètre",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: false,
  volume: true,
  tank_level: false,
  user: user
)

device_5 = Device.create!(
  name: "luminosité #1",
  category: "capteur",
  subcategory: "luminosité",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: true,
  volume: false,
  tank_level: false,
  user: user
)

device_6 = Device.create!(
  name: "environnement #2",
  category: "capteur",
  subcategory: "environnement",
  status: true,
  temperature: true,
  air_rh: true,
  ground_rh: false,
  luminosity: false,
  volume: false,
  tank_level: false,
  user: user
)

device_7 = Device.create!(
  name: "humidité sol #2",
  category: "capteur",
  subcategory: "humidité sol",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: true,
  luminosity: false,
  volume: false,
  tank_level: false,
  user: user
)

device_8 = Device.create!(
  name: "réservoir #2",
  category: "capteur",
  subcategory: "réservoir",
  status: false,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: false,
  volume: false,
  tank_level: true,
  user: user
)

device_9 = Device.create!(
  name: "débitmètre #2",
  category: "capteur",
  subcategory: "débitmètre",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: false,
  volume: true,
  tank_level: false,
  user: user
)

device_10 = Device.create!(
  name: "luminosité #2",
  category: "capteur",
  subcategory: "luminosité",
  status: false,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: true,
  volume: false,
  tank_level: false,
  user: user
)

device_11 = Device.create!(
  name: "environnement #3",
  category: "capteur",
  subcategory: "environnement",
  status: true,
  temperature: true,
  air_rh: true,
  ground_rh: false,
  luminosity: false,
  volume: false,
  tank_level: false,
  user: user
)

device_12 = Device.create!(
  name: "humidité sol #3",
  category: "capteur",
  subcategory: "humidité sol",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: true,
  luminosity: false,
  volume: false,
  tank_level: false,
  user: user
)

device_13 = Device.create!(
  name: "réservoir #3",
  category: "capteur",
  subcategory: "réservoir",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: false,
  volume: false,
  tank_level: true,
  user: user
)

device_14 = Device.create!(
  name: "débitmètre #3",
  category: "capteur",
  subcategory: "débitmètre",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: false,
  volume: true,
  tank_level: false,
  user: user
)

device_15 = Device.create!(
  name: "luminosité #3",
  category: "capteur",
  subcategory: "luminosité",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: true,
  volume: false,
  tank_level: false,
  user: user
)

device_16 = Device.create!(
  name: "environnement #4",
  category: "capteur",
  subcategory: "environnement",
  status: false,
  temperature: true,
  air_rh: true,
  ground_rh: false,
  luminosity: false,
  volume: false,
  tank_level: false,
  user: user
)

device_17 = Device.create!(
  name: "humidité sol #4",
  category: "capteur",
  subcategory: "humidité sol",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: true,
  luminosity: false,
  volume: false,
  tank_level: false,
  user: user
)

device_18 = Device.create!(
  name: "réservoir #4",
  category: "capteur",
  subcategory: "réservoir",
  status: false,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: false,
  volume: false,
  tank_level: true,
  user: user
)

device_19 = Device.create!(
  name: "débitmètre #4",
  category: "capteur",
  subcategory: "débitmètre",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: false,
  volume: true,
  tank_level: false,
  user: user
)

device_20 = Device.create!(
  name: "luminosité #4",
  category: "capteur",
  subcategory: "luminosité",
  status: false,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: true,
  volume: false,
  tank_level: false,
  user: user
)

device_21 = Device.create!(
  name: "arrosage #1",
  category: "actionneur",
  subcategory: "arrosage",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: false,
  volume: false,
  tank_level: false,
  user: user
)

device_22 = Device.create!(
  name: "webcam #1",
  category: "caméra",
  subcategory: "caméra",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: false,
  volume: false,
  tank_level: false,
  user: user
)

puts "devices created"

# Seed Plant
site_name = ["Le Wagon",
  "Jardins de Versailles",
  "Jardin des Plantes",
  "Jardin du Luxembourg"]

plant_info = [{family: "Zamioculcas Zamiifolia",
description: "Zamioculcas is a genus of flowering plants in the family Araceae, containing the single species Zamioculcas zamiifolia. It is a tropical perennial plant native to eastern Africa, from southern Kenya to northeastern South Africa."},
{family: "Philodendron Scandens",
description: "Philodendron hederaceum, the heartleaf philodendron (syn. Philodendron scandens) is a species of flowering plant in the family Araceae, native to Central America and the Caribbean."},
{family: "Pothos",
description: "Pothos is a genus of flowering plants in the family Araceae (tribe Potheae). It is native to China, the Indian Subcontinent, Australia, New Guinea, Southeast Asia, and various islands of the Pacific and Indian Oceans."},
{family: "Monstera",
description: "Monstera is a genus of 49 species of flowering plants in the arum family, Araceae, native to tropical regions of the Americas."},
{family: "Aglaonema",
description: "Aglaonema is a genus of flowering plants in the arum family, Araceae. They are native to tropical and subtropical regions of Asia and New Guinea.[1][2] They are known commonly as Chinese evergreens."}]

plants = []

plant_info.each do |val|
  counter = 0
  4.times do
    species = "#{val[:family][0..1].upcase}_#{counter}"
    plant = Plant.create!(family: val[:family],
          species: species,
          site_name: site_name.sample,
          description: val[:description],
          user: user)
    counter += 1
    plants << plant
  end
end

puts "plants created"

# Seed PlantDevice
def plant_device_create(plant, device)
  PlantDevice.create!(
    plant: plant,
    device: device
  )
end

puts plants[0]
plant_device_create(plants[0], device_1)
plant_device_create(plants[0], device_2)
plant_device_create(plants[0], device_3)
plant_device_create(plants[0], device_4)
plant_device_create(plants[0], device_5)
plant_device_create(plants[0], device_21)
plant_device_create(plants[0], device_22)

plant_device_create(plants[1], device_6)
plant_device_create(plants[1], device_7)
plant_device_create(plants[1], device_3)
plant_device_create(plants[1], device_9)
plant_device_create(plants[1], device_5)

plant_device_create(plants[2], device_11)
plant_device_create(plants[2], device_12)
plant_device_create(plants[2], device_13)
plant_device_create(plants[2], device_14)
plant_device_create(plants[2], device_15)

plant_device_create(plants[3], device_11)
plant_device_create(plants[3], device_17)
plant_device_create(plants[3], device_13)
plant_device_create(plants[3], device_19)
plant_device_create(plants[3], device_15)

puts "plant_devices created"

# Seed DeviceMetric
# Hash establishing the link between DataMetric and Device
hash_data_device = {
  "db/data/data_1_1.csv" => device_1,
  "db/data/data_1_2.csv" => device_2,
  "db/data/data_1_3.csv" => device_3,
  "db/data/data_1_4.csv" => device_4,
  "db/data/data_1_5.csv" => device_5,
  "db/data/data_2_1.csv" => device_6,
  "db/data/data_2_2.csv" => device_7,
  "db/data/data_2_3.csv" => device_3,
  "db/data/data_2_4.csv" => device_9,
  "db/data/data_2_5.csv" => device_5,
  "db/data/data_3_1.csv" => device_11,
  "db/data/data_3_2.csv" => device_12,
  "db/data/data_3_3.csv" => device_13,
  "db/data/data_3_4.csv" => device_14,
  "db/data/data_3_5.csv" => device_15,
  "db/data/data_4_1.csv" => device_11,
  "db/data/data_4_2.csv" => device_17,
  "db/data/data_4_3.csv" => device_13,
  "db/data/data_4_4.csv" => device_19,
  "db/data/data_4_5.csv" => device_15
}

def import_csv_data(filepath, device) # méthode pour instantier une ligne de donnée pour 1 capteur
  CSV.foreach(filepath, headers: :first_row) do |row|
    t = DeviceMetric.new(
      device: device,
      temperature: row['temperature'].to_f,
      air_rh: row['air_rh'].to_f,
      ground_rh: row['ground_rh'].to_f,
      luminosity: row['luminosity'].to_f,
      tank_level: row['tank_level'].to_i,
      volume: row['volume'].to_f,
      created_at: row['Time'],
      updated_at: row['Time']
    )
    t.save
  end
end

hash_data_device.each do |filepath, device|
  import_csv_data(filepath, device)
end
puts "data created"
