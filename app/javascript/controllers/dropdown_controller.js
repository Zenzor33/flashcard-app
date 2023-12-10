import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu"];

  // connect() {}

  toggleMenu() {
    const {
      menuTarget: { classList },
    } = this;
    // If the menu is currently hidden, show it
    if (classList.contains("hidden")) {
      classList.remove("hidden");
      // Use a timeout to allow the browser to render the element before starting the transition
      setTimeout(() => {
        classList.remove("opacity-0", "scale-95");
        classList.add("opacity-100", "scale-100");
      }, 10); // Timeout can be very short, just to defer the removal of 'hidden'
    } else {
      // If the menu is currently shown, hide it
      classList.remove("opacity-100", "scale-100");
      classList.add("opacity-0", "scale-95");

      // Wait for the transition to end before hiding the element
      addEventListener(
        "transitionend",
        () => {
          // Confirm the element is not already hidden and the transition was for the opacity
          if (
            !classList.contains("opacity-100") &&
            event.propertyName === "opacity"
          ) {
            classList.add("hidden");
          }
        },
        { once: true }
      ); // Use { once: true } so the event is automatically removed after it fires
    }
  }
}
