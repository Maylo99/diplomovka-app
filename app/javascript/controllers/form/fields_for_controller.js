import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form--fields-for"
export default class extends Controller {
  hide(e) {
    e.target.closest("[data-target='fields-for.fields']").style = "display: none;"
  }

  add(e) {
    e.preventDefault()
    e.target.insertAdjacentHTML('beforebegin', e.target.dataset.fields.replace(/new_field/g, new Date().getTime()))
  }
}
