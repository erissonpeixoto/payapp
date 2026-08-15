module ApplicationHelper

  BADGE_STYLES = {
    'aberto'    => { color: 'red',    label: 'aberto' },
    'concluido' => { color: 'green',  label: 'concluído' }
  }.freeze

  def badges status
    style = BADGE_STYLES.fetch(status.to_s, { color: 'grey', label: status.to_s })
    "<span class=\"new badge #{style[:color]}\" data-badge-caption=\"#{style[:label]}\"></span>".html_safe
  end

  CHIP_CLASSES = "inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-semibold"

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
