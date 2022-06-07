require 'sidekiq-scheduler'
require 'rubygems'
require 'mqtt'

# require '../services/mqtt_data_builder.rb'


class MqttJob
  include Sidekiq::Worker

  def perform
    puts "test-mqtt"
    MqttDataBuilder.call
  end
end
