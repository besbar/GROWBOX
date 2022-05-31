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
User.new(email:"nolan.vandamme@gmail.com", password:"1234567")

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
until n==20 do
  Plant.create(family:array_title[n], species:array_family[n], site_name:, description:array_description[n], user_id: 1)
end


# Create
