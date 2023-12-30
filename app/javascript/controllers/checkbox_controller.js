import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["checkbox"];

  selectAll(event) {
    console.log("hh");
    console.log(this.checkboxTargets);
    const isChecked = event.target.checked;
    this.checkboxTargets.forEach((checkbox) => {
      checkbox.checked = isChecked;
    });
  }
}
