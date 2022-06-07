class WateringJob < ApplicationJob
  queue_as :default

  def perform
    MqttPlugFour.on
    sleep(10)
    MqttPlugFour.off
  end
end
