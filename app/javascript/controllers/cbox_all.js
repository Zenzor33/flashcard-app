import CheckboxSelectAll from "stimulus-checkbox-select-all";
import { destroy } from "@rails/request.js";

export default class extends CheckboxSelectAll {
  connect() {
    super.connect();
    console.log("Do what you want here.");

    // Get all checked checkboxes
    this.checked;

    // Get all unchecked checkboxes
    this.unchecked;
  }

  destroy(event) {
    event.preventDefault();
    console.log("destroy triggered");
    console.log(this.checked);

    Rails.ajax({
      url: "#",
      type: "DELETE",
      data: "data",
    });
  }
}
