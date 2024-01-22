import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form--toggle-visibility"
export default class extends Controller {
  static targets = ["flag", "toggleElement"]

  connect() {
    this.toggleElementDisplay()
  }

  toggleElementDisplay() {
    if (this.flagTarget.checked) {
      this.toggleElementTarget.classList.add('d-none');
    } else {
      this.toggleElementTarget.classList.remove('d-none');
      this.toggleElementTarget.classList.add('d-block');
    }
  }
}
