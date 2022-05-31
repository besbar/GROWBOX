class RemoveStatusFromDeviceMetric < ActiveRecord::Migration[7.0]
  def change
    remove_column :device_metrics, :status, :boolean
  end
end
