import { Controller } from "@hotwired/stimulus"

// Persists the light/dark choice across visits and reloads. The initial
// value (before this controller even connects) is set by the inline
// anti-flash script in the layout <head> -- this only handles the toggle.
export default class extends Controller {
  toggle() {
    const root = document.documentElement
    const next = root.dataset.theme === "dark" ? "light" : "dark"
    root.dataset.theme = next
    localStorage.setItem("theme", next)
  }
}
