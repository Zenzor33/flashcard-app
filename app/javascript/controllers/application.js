import { Application } from "@hotwired/stimulus";

const application = Application.start();
import CheckboxSelectAll from "stimulus-checkbox-select-all";
application.register("checkbox-select-all", CheckboxSelectAll);

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };
