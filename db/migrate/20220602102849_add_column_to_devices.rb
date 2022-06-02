class AddColumnToDevices < ActiveRecord::Migration[7.0]
  def change
    add_reference :devices, :user, null: false, foreign_key: true
  end
end
