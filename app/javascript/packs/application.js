// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import "bootstrap";
import "../stylesheets/application";
import "@fortawesome/fontawesome-free/js/all";
import "startbootstrap-sb-admin-2/vendor/jquery-easing/jquery.easing";

import "../js/sb-admin-2";
import "../js/preview_image";
import flatpickr from "flatpickr";

document.addEventListener("turbolinks:load", () => {
    $('[data-toggle="tooltip"]').tooltip();
    $('[data-toggle="popover"]').popover();
    flatpickr("[data-behavior='flatpickr']", {
        altInput: true,
        altFormat: "F j, Y",
        maxDate: "today",
    })
});

// Global jquery setup
window.jQuery = $;
window.$ = $;

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//)
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

/* JS and config for function create posts */

import "ckeditor5-build-classic-all-plugin/build/ckeditor";
import "./posts/ckeditor/config";
import "./posts/list-tags";
import "./posts/create-post";
import "jqueryui/jquery-ui";
import "bootstrap-tagsinput/dist/bootstrap-tagsinput";

/* End JS config for function create posts */

/* JS and config for function load page user */

import "../js/user/profile";

/* End JS config for function create posts */
