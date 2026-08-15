import { Controller } from "@hotwired/stimulus"

// Replaces Cocoon: clones a <template> to add a row, and either removes it
// from the DOM (new, unsaved row) or marks it for destruction and hides it
// (already-persisted row, so accepts_nested_attributes_for allow_destroy:
// true can pick it up on submit).
export default class extends Controller {
  static targets = ["template", "list"]

  add(event) {
    event.preventDefault()
    const uniqueId = new Date().getTime()
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, uniqueId)
    this.listTarget.insertAdjacentHTML("beforeend", content)
  }

  remove(event) {
    event.preventDefault()
    const item = event.target.closest(".nested-fields")

    if (item.dataset.newRecord === "true") {
      item.remove()
    } else {
      item.querySelector("input[name*='_destroy']").value = "1"
      item.style.display = "none"
    }
  }
}
