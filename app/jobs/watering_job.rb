class WateringJob < ApplicationJob
  queue_as :default

  def perform
    puts "start_test_watering_job"
    sleep(2)
    puts "end_test_watering_job"
    # flash[:alert] = "L'arrosage se termine"
  end
end
