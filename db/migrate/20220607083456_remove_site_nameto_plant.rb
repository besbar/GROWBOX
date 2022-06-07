class RemoveSiteNametoPlant < ActiveRecord::Migration[7.0]
  def change
    remove_column :plants, :site_name
  end
end
