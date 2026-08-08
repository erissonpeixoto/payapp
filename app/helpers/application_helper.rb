module ApplicationHelper

  BADGE_STYLES = {
    'aberto'    => { color: 'red',    label: 'aberto' },
    'concluido' => { color: 'green',  label: 'concluído' }
  }.freeze

  def badges status
    style = BADGE_STYLES.fetch(status.to_s, { color: 'grey', label: status.to_s })
    "<span class=\"new badge #{style[:color]}\" data-badge-caption=\"#{style[:label]}\"></span>".html_safe
  end

  def badges_boolean boolean, type = nil
    if boolean
      if type == :expense
        '<span class="new badge blue" data-badge-caption="SIM"></span>'.html_safe
      else
        '<span class="new badge green" data-badge-caption="SIM"></span>'.html_safe
      end
    else
      '<span class="new badge grey" data-badge-caption="NÃO"></span>'.html_safe
    end
  end

end
