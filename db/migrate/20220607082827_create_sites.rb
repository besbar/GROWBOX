class CreateSites < ActiveRecord::Migration[7.0]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :address
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
