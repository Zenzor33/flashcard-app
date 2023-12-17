import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="checkbox"
export default class extends Controller {
  static targets = ["selectAll", "checkbox"];

  toggle() {
    this.checkboxTargets.forEach((checkbox) => {
      checkbox.checked = this.selectAllTarget.checked;
    });
  }
}
