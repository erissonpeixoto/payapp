# Custom will_paginate renderer using the Tailwind design tokens instead of
# the Materialize-styled default from the will_paginate-materialize gem.
# Passed explicitly as `will_paginate collection, renderer: "TailwindPaginationRenderer"`
# at each call site -- will_paginate deprecates setting pagination_options[:renderer]
# globally.
#
# will_paginate only requires its ActionView integration lazily, inside an
# ActiveSupport.on_load(:action_view) hook -- which may not have fired yet
# when Zeitwerk eager loads this file, so WillPaginate::ActionView::LinkRenderer
# wouldn't be defined. Require it directly instead of depending on hook timing.
require "will_paginate/view_helpers/action_view"

# Must inherit from ActionView::LinkRenderer (Rails-aware), not the generic
# ViewHelpers::LinkRenderer -- the latter's #url raises NotImplementedError,
# since it doesn't know how to build a Rails path via url_for.
class TailwindPaginationRenderer < WillPaginate::ActionView::LinkRenderer
  protected

  def html_container(html)
    tag(:nav, html, class: "mt-6 flex items-center justify-center gap-1 text-sm", "aria-label": "Paginação")
  end

  def page_number(page)
    aria_label = "Página #{page}"
    if page == current_page
      tag(:em, page, class: "flex h-8 w-8 items-center justify-center rounded-md bg-accent font-medium not-italic text-accent-contrast", "aria-label": aria_label, "aria-current": "page")
    else
      link(page, page, rel: rel_value(page), "aria-label": aria_label, class: "flex h-8 w-8 items-center justify-center rounded-md text-ink-soft hover:bg-paper-sunken hover:text-ink")
    end
  end

  def gap
    %(<span class="flex h-8 w-8 items-center justify-center text-ink-faint">&hellip;</span>)
  end

  # will_paginate 4.x added a 4th (aria_label) parameter here -- but the base
  # class builds it via will_paginate_translate with a block, and this
  # gem version's ActionView-integrated translate path ignores that block,
  # so it always comes back nil. Provide our own instead.
  def previous_or_next_page(page, text, classname, aria_label = nil)
    aria_label ||= classname == "previous_page" ? "Página anterior" : "Próxima página"
    base = "flex h-8 items-center gap-1 rounded-md px-3 #{classname}"
    if page
      link(text, page, "aria-label": aria_label, class: "#{base} text-ink-soft hover:bg-paper-sunken hover:text-ink")
    else
      tag(:span, text, "aria-label": aria_label, class: "#{base} text-ink-faint opacity-50")
    end
  end
end
