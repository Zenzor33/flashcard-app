import { Application } from "@hotwired/stimulus";

const application = Application.start();
import CheckboxSelectAll from "stimulus-checkbox-select-all";
application.register("checkbox-select-all", CheckboxSelectAll);

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

import CboxAll from "./cbox_all.js";
application.register("cbox-all", CboxAll);

export { application };
