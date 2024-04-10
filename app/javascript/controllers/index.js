// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import AutomaticAccountingController from "./automatic_accounting_controller"
application.register("automatic-accounting", AutomaticAccountingController)
import Accounts__AccountScopeController from "./accounts/account_scope_controller"
application.register("accounts--account-scope", Accounts__AccountScopeController)

import Form__FieldsForController from "./form/fields_for_controller"
application.register("form--fields-for", Form__FieldsForController)

import Form__ToggleVisibilityController from "./form/toggle_visibility_controller"
application.register("form--toggle-visibility", Form__ToggleVisibilityController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import PaymentOptionsController from "./payment_options_controller"
application.register("payment-options", PaymentOptionsController)

import SemanticSearchController from "./semantic_search_controller"
application.register("semantic-search", SemanticSearchController)
