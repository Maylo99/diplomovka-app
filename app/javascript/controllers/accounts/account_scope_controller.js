import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="accounts--account-scope"
export default class extends Controller {
    static targets = ["anchor"]

    changeWorkingAccount(event) {
        const resources = ["sales_invoices","supplier_invoices","bank_statements", "expenses","income_expenses","charge_expenses","main_books"]
        const selectedAccountId = event.target.value;
        let new_path = "/";

        if (selectedAccountId !== "accounts/new") {
            const path = window.location.pathname;
            if (path === '/' || isNaN(path.split("/")[2])) {
                new_path += "accounts"+`/${selectedAccountId}/sales_invoices`;
            } else {
                let resource = path.split("/")[3]
                if (resource && resources.includes(resource)) {
                    new_path += "accounts/"+ selectedAccountId +"/"+ resource;
                } else {
                    new_path = path.replace(/^\/[^/]+/, `/${selectedAccountId}`);
                }
            }
        } else {
            new_path = "accounts/new";
        }

        this.anchorTarget.href = new_path;
        this.anchorTarget.click();
    }
}
