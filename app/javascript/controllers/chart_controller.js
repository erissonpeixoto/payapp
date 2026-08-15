import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js"

// "chart.js/auto" auto-registers every controller/element/scale for us,
// but it can't be vendored offline as-is (see the comment in
// vendor/javascript/chart.js.js) -- so we import the plain "chart.js"
// package instead and register everything ourselves, once per page load.
Chart.register(...registerables)

// Draws a pie/bar/line chart on a <canvas>, reading data from Stimulus
// values (rendered server-side by the controller) and colors from the
// app's CSS custom properties (app/assets/tailwind/application.css) so
// charts follow the design tokens and redraw on light/dark toggle
// instead of hardcoding hex values here.
export default class extends Controller {
  static values = {
    type: String,
    labels: Array,
    data: Array,
    color: { type: String, default: "accent" },
  }

  connect() {
    this.draw()
    this.onThemeChange = () => this.redraw()
    window.addEventListener("theme:changed", this.onThemeChange)
  }

  disconnect() {
    this.chart?.destroy()
    window.removeEventListener("theme:changed", this.onThemeChange)
  }

  redraw() {
    this.chart?.destroy()
    this.draw()
  }

  draw() {
    const token = (name) => getComputedStyle(document.documentElement).getPropertyValue(`--color-${name}`).trim()
    const ink = token("ink-soft")
    const gridColor = token("line")
    const surface = token("paper-raised")
    const mainColor = token(this.colorValue)
    const currency = new Intl.NumberFormat("pt-BR", { style: "currency", currency: "BRL" })

    const isPie = this.typeValue === "pie"
    const isLine = this.typeValue === "line"

    this.chart = new Chart(this.element, {
      type: this.typeValue,
      data: {
        labels: this.labelsValue,
        datasets: [{
          data: this.dataValue,
          backgroundColor: isPie
            ? [token("accent"), this.dataValue[1] < 0 ? token("expense") : token("revenue")]
            : isLine ? `${mainColor}22` : mainColor,
          borderColor: isPie ? surface : mainColor,
          borderWidth: isPie ? 3 : isLine ? 2 : 0,
          borderRadius: this.typeValue === "bar" ? 6 : 0,
          maxBarThickness: 56,
          tension: isLine ? 0.35 : 0,
          pointRadius: isLine ? 3 : 0,
          pointBackgroundColor: mainColor,
          fill: isLine,
        }],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: isPie,
            position: "bottom",
            labels: { color: ink, boxWidth: 10, boxHeight: 10, padding: 16 },
          },
          tooltip: {
            backgroundColor: surface,
            titleColor: ink,
            bodyColor: ink,
            borderColor: gridColor,
            borderWidth: 1,
            padding: 10,
            callbacks: {
              label: (ctx) => ` ${currency.format(ctx.parsed.y ?? ctx.parsed)}`,
            },
          },
        },
        scales: isPie ? {} : {
          x: { ticks: { color: ink }, grid: { display: false } },
          y: {
            ticks: { color: ink, callback: (value) => currency.format(value) },
            grid: { color: gridColor },
            border: { display: false },
          },
        },
      },
    })
  }
}
