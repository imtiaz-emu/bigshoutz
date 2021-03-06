// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require('jquery');
require('popper.js/dist/umd/popper');
require('packs/bootstrap.bundle.min');
require('packs/owl.carousel.min');
require('packs/owl.carousel2.thumbs.min');
require('packs/custom');
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start();
Turbolinks.start();
ActiveStorage.start();

$(document.body).tooltip({
  selector: "[data-toggle='tooltip']",
  trigger: "hover"
});
