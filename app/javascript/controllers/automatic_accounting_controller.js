import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="automatic-accounting"
export default class extends Controller {
  static targets = ["doAccount","docType"]
  connect() {
    const accountOptions = document.querySelectorAll('.automatic-group');
  }

  automaticAccount(){
      const automaticGroups = document.querySelectorAll('.automatic-group');
      let account=[]
      automaticGroups.forEach(group => {
          group.querySelectorAll('.account_option').forEach(option=>{
              account.push(option.value)
          });
      });
      this.makePrediction(account[0],account[1],account[2]).then(data=>{
          var data = JSON.parse(data)
          if (this.doAccountTarget.checked){
              automaticGroups.forEach(group => {
                  const accountOptionInput = group.querySelector('.account_option');
                  // Find the input with class "account_side" in the current group
                  console.log(data)
                  const accountSideInput = group.querySelector('.account_side');
                  if (accountOptionInput && data[accountOptionInput.value] === 'md') {
                      accountSideInput.value = 'MD';
                  } else {
                      accountSideInput.value = 'D';
                  }
              });
          }
      }).catch(error => {
          console.error(error); // Handle errors here
      });
  }

  async makePrediction(acc1,acc2,acc3) {
    const url = new URL('http://localhost:8000/decision_tree');

    url.searchParams.append('account1',  acc1 || 0);
    url.searchParams.append('account2', acc2 || 0);
    url.searchParams.append('account3', acc3 || 0);
    url.searchParams.append('document', this.docTypeTarget.value);
    console.log(url)
    const requestData = {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
    };

    try {
      const response = await fetch(url, requestData);
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      const responseData = await response.json();
      return responseData
    } catch (error) {
      console.error('Error:', error);
    }
  }
}
