crumb :root do
  link "Accueil", "/dashboard"
end

crumb :plants do
  link "Mes plantes", plants_path
end

crumb :plant do |plant|
  link plant.family, plant_path(plant)
  parent :plants
end

crumb :new_plant do |plant|
  link "Ajouter", new_plant_path(plant)
  parent :plants
end

crumb :edit_plant do |plant|
  link "Modifier", edit_plant_path(plant)
  parent :plant, plant
end

crumb :devices do
  link "Mes capteurs", devices_path
end

crumb :device do |device|
  link device.name, device_path(device)
  parent :devices
end

crumb :new_device do |device|
  link "Ajouter", new_device_path(device)
  parent :devices
end

crumb :sites do
  link "Mes sites", sites_path
end

crumb :site do |site|
  link site.name, site_path(site)
  parent :sites
end

crumb :new_site do |site|
  link "Ajouter", new_site_path(site)
  parent :sites
end
