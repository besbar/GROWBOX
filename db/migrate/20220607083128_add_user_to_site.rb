class AddUserToSite < ActiveRecord::Migration[7.0]
  def change
    add_reference :sites, :user, null: false, foreign_key: true
  end
end
