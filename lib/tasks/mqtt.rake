namespace :mqtt do
  desc "Listen MQTT chanels"
  task listen: :environment do
    METRIC_NAME_PER_CHANNEL_NAME = {
      'air_temp' => 'temperature',
      'air_humi' => 'air_rh'
    }

    client = MQTT::Client.connect(
      :host => '10.20.1.137',
      :port => 1883,
      :user => "jb",
      :password => "growbox",
      :ssl => false
    )

    client.get do |topic,message|
      # Block is executed for every message received
      match_data = topic.match(/(?<channel_name>[a-z_]+)_(?<channel_id>\d)/)
      channel_name = match_data[:channel_name]
      channel_id = match_data[:channel_id]
      device = Device.find_by(channel_id: channel_id)
      metric_name = METRIC_NAME_PER_CHANNEL_NAME[channel_name]
      DeviceMetric.create(device: device, metric_name => message)
    end
  end
end
