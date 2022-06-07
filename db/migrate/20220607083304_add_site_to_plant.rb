class AddSiteToPlant < ActiveRecord::Migration[7.0]
  def change
    add_reference :plants, :site, null: false, foreign_key: true
  end
end
