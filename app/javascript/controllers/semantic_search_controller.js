import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="semantic-search"
export default class extends Controller {
    static targets = ["expression", "selectAccount","inputAccount", "automatic"]

    connect() {
        this.inputAccountTarget.style.display = 'none';
        this.toggleInput()
    }

    search() {
        this.toggleInput()
        if (this.automaticTarget.checked && this.expressionTarget.value) {
            this.performSemanticSearch(this.expressionTarget.value)
                .then(data => {
                    console.log(data); // Handle the response data here
                    this.updateSelectOptions(data)
                    console.log(this.selectAccountTarget)
                })
                .catch(error => {
                    console.error(error); // Handle errors here
                });
        }
    }

    toggleInput(){
        if (this.automaticTarget.checked) {
            this.selectAccountTarget.style.display = '';
            this.inputAccountTarget.style.display = 'none';
        } else {
            this.selectAccountTarget.style.display = 'none';
            this.inputAccountTarget.style.display = '';
        }
    }

    updateSelectOptions(data) {
        const selectAccount = this.selectAccountTarget;
        selectAccount.innerHTML = "";
        for (const key in data) {
            for (const [text, value] of Object.entries(data[key])) {
                const optionElement = document.createElement("option");
                optionElement.value = value; // Set the value
                optionElement.text = text; // Set the display text
                this.selectAccountTarget.appendChild(optionElement);
            }
            ;
        }
    }

    async performSemanticSearch(sentence) {
        const url = new URL('http://localhost:8000/semantic_search');
        url.searchParams.append('sentence', sentence);
        const response = await fetch(url, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        });
        if (!response.ok) {
            const errorMessage = `An error has occurred: ${response.status}`;
            throw new Error(errorMessage);
        }
        return await response.json();
    }
}
