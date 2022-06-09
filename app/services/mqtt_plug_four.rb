require 'rubygems'
require 'mqtt'

class MqttPlugFour

  # def self.call
  #   new.build_data
  # end
  def self.on
    new.switch_on
  end

  def self.off
    new.switch_off
  end

  def initialize
    @client = {
      host: ENV.fetch('MQTT_HOST'),
      #:host => 'test.mosquitto.org',
      #:host => '192.168.1.105',
      port: ENV.fetch('MQTT_PORT').to_i,
      username: "jb",
      password: "growbox"
    }
  end

  def switch_on
    MQTT::Client.connect(@client) do |c|
      c.publish('Plug4_4', 'On')
      c.disconnect()
    end
  end

  def switch_off
    MQTT::Client.connect(@client) do |c|
      c.publish('Plug4_4', 'Off')
      c.disconnect()
    end
  end
end
