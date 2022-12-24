module ApplicationHelper

  def badges status
    if status == "aberto"
      '<span class="new badge red" data-badge-caption="aberto"></span>'.html_safe
    elsif status == "concluido"
      '<span class="new badge green" data-badge-caption="concluído"></span>'.html_safe
    else
      '<span class="new badge grey" data-badge-caption="' "#{status.to_s}"+'></span>'.html_safe
    end
  end

  def badges_boolean boolean
    if boolean
      '<span class="new badge green" data-badge-caption="SIM"></span>'.html_safe
    else
      '<span class="new badge grey" data-badge-caption="NÃO"></span>'.html_safe
    end
  end

end
