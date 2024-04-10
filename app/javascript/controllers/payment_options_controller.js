import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="payment-options"
export default class extends Controller {
  static targets = ["paymentMethod","transactionDetails"]
  connect() {
    this.toggleTransactionDetails()
  }


  toggleTransactionDetails(){
    if(this.paymentMethodTarget.value!="Bankový prevod"){
      this.transactionDetailsTarget.style.display='none'
    }else{
      this.transactionDetailsTarget.style.display=''
    }
  }
}
