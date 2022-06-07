class RemoveUserToPlant < ActiveRecord::Migration[7.0]
  def change
    remove_column :plants, :user_id
  end
end
