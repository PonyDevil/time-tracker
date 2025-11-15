import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display"]
  static values = { startTime: Number }

  connect() {
    const startTime = this.startTimeValue
    if (startTime && startTime > 0) {
      this.startTimer(startTime)
    }
  }

  start() {
    const now = Date.now()
    this.startTimeValue = now
    this.startTimer(now)
  }

  stop() {
    clearInterval(this.interval)
    this.displayTarget.textContent = ""
  }

  startTimer(startTime) {
    clearInterval(this.interval)
    this.interval = setInterval(() => {
      const elapsed = Math.floor((Date.now() - startTime) / 1000)
      const minutes = String(Math.floor(elapsed / 60)).padStart(2, '0')
      const seconds = String(elapsed % 60).padStart(2, '0')
      this.displayTarget.textContent = `${minutes}:${seconds}`
    }, 500)
  }

  disconnect() {
    clearInterval(this.interval)
  }
}