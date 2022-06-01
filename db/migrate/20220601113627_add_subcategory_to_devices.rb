class AddSubcategoryToDevices < ActiveRecord::Migration[7.0]
  def change
    add_column :devices, :subcategory, :string
  end
end
