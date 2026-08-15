import { Controller } from "@hotwired/stimulus"

// Wraps Materialize's vanilla Sidenav component. Reconnects on every Turbo
// visit automatically (Stimulus lifecycle), replacing the old
// turbolinks:load / turbolinks:before-visit listener pair.
export default class extends Controller {
  connect() {
    this.instance = M.Sidenav.init(this.element, {})
  }

  disconnect() {
    this.instance?.destroy()
  }
}
