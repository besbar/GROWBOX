import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="webcam"
export default class extends Controller {
  connect() {
    console.log('Hello from webcam controller')

  }

  api(event) {
    console.log('Hello from API function')
    // fetch('https://10.20.0.1:2000/cgi-bin/api.cgi?cmd=Snap&channel=0&rs=wuuPhkmUCeI9WG7C&user=admin&password=growbox')
    // get the image from this url

    // make a second API call and retrieve JSON result

  }
}
