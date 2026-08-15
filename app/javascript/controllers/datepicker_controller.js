import { Controller } from "@hotwired/stimulus"

// Wraps Materialize's vanilla M.Datepicker (bundled in materialize.min.js).
// Replaces the old jQuery-based vendor/assets/materialize/js/datepicker.js
// plugin and its $(document).ready/cocoon:after-insert rebind hack --
// Stimulus connects this controller automatically for every matching
// element, including ones inserted later by the nested-form controller.
export default class extends Controller {
  connect() {
    this.instance = M.Datepicker.init(this.element, {
      format: "dd/mm/yyyy",
      autoClose: true,
    })
  }

  disconnect() {
    this.instance?.destroy()
  }
}
