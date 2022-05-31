# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "open-uri"
require "nokogiri"

#Create one user
user = User.new(
  first_name: "JB",
  last_name: "Taffin",
  company: "akagreen",
  email:"nolan.vandamme@gmail.com",
  password:"1234567"
)
user.save

#Create plants - basé sur https://www.conservation-nature.fr/types/arbuste/

#Get content
html_file = File.open("db/seeds/plantes.html")
html_doc = Nokogiri::HTML(html_file)

#Define methods to extract text, images and url
def array_building(html, search_content)
  array = []
  html.search(search_content).each do |element|
    array << element.text
  end
  array = array[22...42]
end

def change_url(array)
  array.map! do |url|
    "https://www.conservation-nature.fr/plante/#{url.downcase.gsub(' ', '-')}"
  end
end

def get_image(html, search_content)
  array = []
  html.search(search_content).each do |image|
  array << image.attribute("data-bg").value
  end
  array = array[22...42]
end

array_title = array_building(html_doc, "#bloc_especes .nom_francais")
array_family = array_building(html_doc, "#bloc_especes .plante_famille")
array_image = get_image(html_doc, "#bloc_especes .vignette-haut")
array_url = change_url(array_building(html_doc, "#bloc_especes .nom_latin"))

array_description = []
array_url.each do |url|
  html_file_plant = URI.open(url).read
  html_doc_plant = Nokogiri::HTML(html_file_plant)
  array_description << html_doc_plant.search(".bloc_centre p").text
end

#Create plant instances
# famille, espèces, description, location
for n in 1..19 do
  Plant.create(family:array_title[n], species:array_family[n], site_name:"le wagon", description:array_description[n], user_id: 1)
end

csv_1_1 = File.read(Rails.root.join('db', 'data_1_1.csv'))

BULK_SIZE = 500

device_1 = Device.create!(
  name: "Environment #1",
  category: "capteur",
  status: true,
  temperature: true,
  air_rh: true,
  ground_rh: false,
  luminosity: false,
  volume: false,
  tank_level: false
)

device_2 = Device.create!(
  name: "Soil Humidity #1",
  category: "capteur",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: true,
  luminosity: false,
  volume: false,
  tank_level: false
)

device_3 = Device.create!(
  name: "Tank Level #1",
  category: "capteur",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: false,
  volume: false,
  tank_level: true
)

device_4 = Device.create!(
  name: "Débitmètre #1",
  category: "capteur",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: false,
  volume: true,
  tank_level: false
)

device_5 = Device.create!(
  name: "Luminance #1",
  category: "capteur",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: true,
  volume: false,
  tank_level: false
)

device_6 = Device.create!(
  name: "Environment #2",
  category: "capteur",
  status: true,
  temperature: true,
  air_rh: true,
  ground_rh: false,
  luminosity: false,
  volume: false,
  tank_level: false
)

device_7 = Device.create!(
  name: "Soil Humidity #2",
  category: "capteur",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: true,
  luminosity: false,
  volume: false,
  tank_level: false
)

device_8 = Device.create!(
  name: "Tank Level #2",
  category: "capteur",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: false,
  volume: false,
  tank_level: true
)

device_9 = Device.create!(
  name: "Débitmètre #2",
  category: "capteur",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: false,
  volume: true,
  tank_level: false
)

device_10 = Device.create!(
  name: "Luminance #2",
  category: "capteur",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: true,
  volume: false,
  tank_level: false
)

device_11 = Device.create!(
  name: "Environment #3",
  category: "capteur",
  status: true,
  temperature: true,
  air_rh: true,
  ground_rh: false,
  luminosity: false,
  volume: false,
  tank_level: false
)

device_12 = Device.create!(
  name: "Soil Humidity #3",
  category: "capteur",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: true,
  luminosity: false,
  volume: false,
  tank_level: false
)

device_13 = Device.create!(
  name: "Tank Level #3",
  category: "capteur",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: false,
  volume: false,
  tank_level: true
)

device_14 = Device.create!(
  name: "Débitmètre #3",
  category: "capteur",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: false,
  volume: true,
  tank_level: false
)

device_15 = Device.create!(
  name: "Luminance #3",
  category: "capteur",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: true,
  volume: false,
  tank_level: false
)

device_16 = Device.create!(
  name: "Environment #4",
  category: "capteur",
  status: true,
  temperature: true,
  air_rh: true,
  ground_rh: false,
  luminosity: false,
  volume: false,
  tank_level: false
)

device_17 = Device.create!(
  name: "Soil Humidity #4",
  category: "capteur",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: true,
  luminosity: false,
  volume: false,
  tank_level: false
)

device_18 = Device.create!(
  name: "Tank Level #4",
  category: "capteur",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: false,
  volume: false,
  tank_level: true
)

device_19 = Device.create!(
  name: "Débitmètre #4",
  category: "capteur",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: false,
  volume: true,
  tank_level: false
)

device_20 = Device.create!(
  name: "Luminance #4",
  category: "capteur",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: true,
  volume: false,
  tank_level: false
)

device_21 = Device.create!(
  name: "pompe d'arrosage #1",
  category: "actionneur",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: false,
  volume: false,
  tank_level: false
)

device_22 = Device.create!(
  name: "webcam #1",
  category: "camera",
  status: true,
  temperature: false,
  air_rh: false,
  ground_rh: false,
  luminosity: false,
  volume: false,
  tank_level: false
)

# metrics = []
# CSV.foreach(csv_1_1, :headers => true, :encoding => 'ISO-8859-1') do
#   metric = DeviceMetric.new(
#     device: device_1,
#     temperature: row['temperature'],
#     air_rh: row['air_rh'],
#     ground_rh: row['ground_rh'],
#     luminosity: row['luminosity'],
#     tank_level: row['tank_level'],
#     volume: row['volume']
#   )

#   metrics << metric

#   if metrics.size >= BULK_SIZE
#     DeviceMetric.import metrics
#     metrics = []
#   end
# end

# if metrics.size > 0
#   DeviceMetric.import metrics
# end
