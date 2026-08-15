module ApplicationHelper

  CHIP_CLASSES = "inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-semibold"

  STATUS_CHIP_STYLES = {
    'aberto'    => { classes: "bg-accent-tint/15 text-accent", label: 'Aberto' },
    'concluido' => { classes: "bg-revenue-tint/15 text-revenue", label: 'Concluído' },
  }.freeze

  def badges(status)
    style = STATUS_CHIP_STYLES.fetch(status.to_s, { classes: "bg-paper-sunken text-ink-soft", label: status.to_s })
    content_tag(:span, style[:label], class: "#{CHIP_CLASSES} #{style[:classes]}")
  end

  # `type` no longer changes the color (it used to pick blue vs. green) --
  # kept only so the pre-redesign payments/show.html.erb call sites
  # (:expense/:revenue) keep working; drop it once that page is migrated.
  def badges_boolean(boolean, type = nil)
    if boolean
      content_tag(:span, "Sim", class: "#{CHIP_CLASSES} bg-revenue-tint/15 text-revenue")
    else
      content_tag(:span, "Não", class: "#{CHIP_CLASSES} bg-paper-sunken text-ink-faint")
    end
  end

end
