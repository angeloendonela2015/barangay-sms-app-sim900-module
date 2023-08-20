// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

document.addEventListener('DOMContentLoaded', function() {
  const selectAllCheckbox = document.querySelector('.select-all-checkbox');
  const userCheckboxes = document.querySelectorAll('[name="user_ids[]"]');

  selectAllCheckbox.addEventListener('change', function() {
    userCheckboxes.forEach(function(checkbox) {
      checkbox.checked = selectAllCheckbox.checked;
    });
  });
});

