import { Controller } from "@hotwired/stimulus";

function debounce(func, wait) {
  let timeout;
  return function (...args) {
    const context = this;
    if (timeout) clearTimeout(timeout);
    timeout = setTimeout(() => {
      timeout = null;
      func.apply(context, args);
    }, wait);
  };
}

// Connects to data-controller="form"
export default class extends Controller {
  connect() {}

  submit = debounce(function () {
    this.element.requestSubmit();
  }, 500);
}
