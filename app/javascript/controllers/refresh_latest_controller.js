import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["temperatureAirRH", "tankLevel", "groundRH"];
  static values = {metricsUrl: String};

  connect() {
    setInterval(this.#refreshMetrics.bind(this), 5000);
  }

  #refreshMetrics() {
      fetch(this.metricsUrlValue)
      .then(response => response.json())
      .then((data) => {
        this.temperatureAirRHTarget.outerHTML = data.temperature_air_rh
        this.tankLevelTarget.outerHTML = data.tank_level
        this.groundRHTarget.outerHTML = data.ground_rh
      })

  }
}
