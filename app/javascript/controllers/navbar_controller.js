import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  connect() {
  }

  updateNavbar() {
    if (window.scrollY >= 160) {
      this.element.classList.add("navbar-lewagon-blue")
    } else {
      this.element.classList.remove("navbar-lewagon-blue")
    }
  }
}
