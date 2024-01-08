import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="studycard"
export default class extends Controller {
  toggleCard() {
    const frontElement = document.getElementById("front");
    const backElement = document.getElementById("back");

    frontElement.classList.toggle("hidden");
    backElement.classList.toggle("hidden");
  }
}
