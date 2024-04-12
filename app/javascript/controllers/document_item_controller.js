import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="document-item"
export default class extends Controller {
  static targets = [ "quantity", "unitPrice", "totalPrice", "VAT", "totalPriceVAT"];
  connect() {
    this.calculateTotal()
    this.calculateTotalVAT()
  }

  calculateTotal() {
    const quantity = parseFloat(this.quantityTarget.value);
    const unitPrice = parseFloat(this.unitPriceTarget.value);
    const totalPrice = quantity * unitPrice;
    this.totalPriceTarget.value = Number.isNaN(totalPrice) ? '' : totalPrice;
  }

  calculateTotalVAT() {
    const totalPrice = parseFloat(this.totalPriceTarget.value);
    const totalPriceVat = totalPrice + ((totalPrice * parseFloat(this.VATTarget.value)) / 100);
    this.totalPriceVATTarget.value = Number.isNaN(totalPriceVat) ? '' : totalPriceVat;
  }
}