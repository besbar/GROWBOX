require 'rubygems'
require 'mqtt'

namespace :mqtt do
  desc "Listen MQTT channels"
  task listen: :environment do
    METRIC_NAME_PER_CHANNEL_NAME = {
      'air_temp' => 'temperature',
      'air_humi' => 'air_rh',
      'soil_humi' => 'ground_rh',
      'flow_meter' => 'volume',
      'tank_level' => 'tank_level'
    }

    TOPIC_PER_DEVICE_ID = {
      'air_temp_4' => Device.first,
      'air_humi_4' => Device.first,
      'soil_humi_4' => Device.find(2),
      'flow_meter_4' => Device.find(4),
      'tank_level_4' => Device.find(3)
    }

    client = MQTT::Client.new(
      :host => '10.20.1.137',
      #:host => 'test.mosquitto.org',
      #:host => '192.168.1.105',
      :port => 1883,
      :username => "jb",
      :password => "growbox"
    )
    client.connect()

    # client.subscribe('air_temp_4', 'air_humi_4', 'soil_humi_4', 'flowMeter_4', 'tank_4')
    client.subscribe('air_temp_4', 'air_humi_4', 'soil_humi_4', 'flow_meter_4', 'tank_level_4')
    #client.connect() do |c|
      # If you pass a block to the get method, then it will loop
      client.get do |topic,message|
        puts "#{topic}: #{message}"
        match_data = topic.match(/(?<channel_name>[a-z_]+)_(?<channel_id>\d)/)
        channel_name = match_data[:channel_name]
        puts channel_name
        channel_id = match_data[:channel_id]
        device = TOPIC_PER_DEVICE_ID[topic]
        puts device.name
        metric_name = METRIC_NAME_PER_CHANNEL_NAME[channel_name]
        puts metric_name
        puts DeviceMetric.create(device: device, metric_name => message)
        client.publish('test', "The time is: #{Time.now}")
      end
    #end


    # client.get do |topic,message|
      # Block is executed every message received
      # puts "#{topic}: #{message}"
      # match_data = topic.match(/(?<channel_name>[a-z_]+)_(?<channel_id>\d)/)
      # channel_name = match_data[:channel_name]
      # channel_id = match_data[:channel_id]
      # # device = Device.find_by(channel_id: channel_id)
      # device = TOPIC_PER_DEVICE_ID[topic]
      # metric_name = METRIC_NAME_PER_CHANNEL_NAME[channel_name]
      # DeviceMetric.create(device: device, metric_name => message)
    # end
  end
end

# client.disconnect()
