import { Controller } from "@hotwired/stimulus"

// Mobile nav drawer. Reconnects fresh (closed) on every Turbo visit since
// the header is part of the layout re-rendered on each navigation.
export default class extends Controller {
  static targets = ["panel", "button"]

  toggle() {
    const isOpen = !this.panelTarget.classList.contains("hidden")
    this.panelTarget.classList.toggle("hidden")
    this.buttonTarget.setAttribute("aria-expanded", String(!isOpen))
  }

  close() {
    this.panelTarget.classList.add("hidden")
    this.buttonTarget.setAttribute("aria-expanded", "false")
  }
}
