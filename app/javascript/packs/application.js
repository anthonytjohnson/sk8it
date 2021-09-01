// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"


Rails.start()
Turbolinks.start()
ActiveStorage.start()

// External imports
import "bootstrap";
import 'swiper/swiper-bundle.min.css'

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
import { initMapbox } from '../plugins/init_mapbox';
import { initDropdown } from '../plugins/init_dropdown';
import { initAutocomplete } from '../plugins/init_autocomplete';
// import { commentsToggle } from '../plugins/commentstoggle';

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  window.Rails = Rails
  initMapbox();
  initDropdown();
  initAutocomplete();
  // commentsToggle();
});



import "controllers"
