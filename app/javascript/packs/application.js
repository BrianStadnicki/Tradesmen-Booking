// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

//= require jquery3
//= require popper
//= require bootstrap
//= require serviceworker-companion
//= require notifications
//= require paginate
//= require 'new-registration-interactive'

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap"
import "../serviceworker-companion"
import "../notifications"
import "../paginate"
import "../new-registration-interactive"
import 'stylesheets/application'

Rails.start()
Turbolinks.start()
ActiveStorage.start()
