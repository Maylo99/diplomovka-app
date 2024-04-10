import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="automatic-accounting"
export default class extends Controller {
    static targets = ["doAccount", "docType", "caseAccountSide", "invoiceAccountSide", "dphAccountSide", "dphAccount", "invoiceAccount", "caseAccountInput", "caseAccountSelect"]

    automaticAccount() {
        let caseAccountValue = 0
        if (this.caseAccountInputTarget.value) {
            caseAccountValue = this.caseAccountInputTarget.value
        } else {
            caseAccountValue = this.caseAccountSelectTarget.value
        }
        let invoiceAccountValue = this.invoiceAccountTarget.value
        let dphAccountValue = this.dphAccountTarget.value
        this.makePrediction(caseAccountValue, invoiceAccountValue, dphAccountValue).then(data => {
            var data = JSON.parse(data)
            if (this.doAccountTarget.checked) {
                data = this.edit_api_output_format(data)
                if (data[dphAccountValue]) {
                    this.dphAccountSideTarget.value = data[dphAccountValue]
                }
                if (data[invoiceAccountValue]) {
                    this.invoiceAccountSideTarget.value = data[invoiceAccountValue]
                }
                if (data[caseAccountValue]) {
                    this.caseAccountSideTarget.value = data[caseAccountValue]
                }
            }
        }).catch(error => {
            console.error(error); // Handle errors here
        });
    }

    edit_api_output_format(data) {
        for (let key in data) {
            // Check if the length of the key is 2
            if (key.length === 2) {
                // Prepend "0" to the key
                const newKey = "0" + key;
                // Assign the value of the original key to the new key
                data[newKey] = data[key];
                // Delete the original key-value pair
                delete data[key];
            }
        }
        return data
    }

    async makePrediction(acc1, acc2, acc3) {
        const url = new URL('http://localhost:8000/decision_tree');
        url.searchParams.append('account1', acc1 || 0);
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
