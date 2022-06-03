require 'rubygems'
require 'mqtt'

class MqttDataBuilder

  def self.call
    new.build_data
  end

  def initialize
    @client = {
      host: '10.20.1.137',
      port: 1883,
      username: "jb",
      password: "growbox"
    }
  end

  def build_data
    MQTT::Client.connect(@client) do |c|

      c.subscribe('air_temp_4', 'air_humi_4', 'soil_humi_4', 'flow_meter_4', 'tank_level_4', 'end_call')

      c.publish('sensors_4', 'test')

      metric_name_per_channel_name = {
        'air_temp' => 'temperature',
        'air_humi' => 'air_rh',
        'soil_humi' => 'ground_rh',
        'flow_meter' => 'volume',
        'tank_level' => 'tank_level'
      }

      topic_per_device_id = {
        'air_temp_4' => Device.first,
        'air_humi_4' => Device.first,
        'soil_humi_4' => Device.find(2),
        'flow_meter_4' => Device.find(4),
        'tank_level_4' => Device.find(3)
      }

      data = {}

      c.get do |topic, message|
        data[topic] = message
        if ['air_temp_4', 'air_humi_4', 'soil_humi_4', 'flow_meter_4', 'tank_level_4'].include?(topic)
          match_data = topic.match(/(?<channel_name>[a-z_]+)_(?<channel_id>\d)/)
          channel_name = match_data[:channel_name]
          channel_id = match_data[:channel_id]
          device = topic_per_device_id[topic]
          metric_name = metric_name_per_channel_name[channel_name]
          puts DeviceMetric.create(device: device, metric_name => message)
        end
        break if topic == 'end_call' && message == '1'
      end
      return data
    end
  end
end
