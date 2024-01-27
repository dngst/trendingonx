import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["dropdown"];

  connect() {
    this.hideDropdown();
    this.hideDropdownOnClickOutside();
  }

  toggleDropdown() {
    this.dropdownTarget.classList.toggle("hidden");
  }

  hideDropdownOnClickOutside() {
    document.addEventListener("click", (event) => {
      if (!this.element.contains(event.target)) {
        this.hideDropdown();
      }
    });
  }

  hideDropdown() {
    if (!this.dropdownTarget.classList.contains("hidden")) {
      this.dropdownTarget.classList.add("hidden");
    }
  }
}
