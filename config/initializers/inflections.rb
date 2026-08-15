# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end

# Rails' inflector only ships rules for :en. Since config.i18n.default_locale
# is pt-BR (config/application.rb), any `pluralize(count, word)` call resolves
# its plural under the pt-BR locale by default and silently returns the
# singular unchanged when no rule is registered for it -- e.g. pluralize(2,
# "despesa") => "2 despesa" instead of "2 despesas". Most Portuguese nouns
# used in this app pluralize by simply appending "s", so a single catch-all
# rule covers them; irregular words (still uncommon here) can add their own
# `inflect.irregular`/`inflect.plural` rule above this one.
ActiveSupport::Inflector.inflections(:'pt-BR') do |inflect|
  inflect.plural(/$/, 's')
end
