# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

#Configuracao para mostrar data no show
Time::DATE_FORMATS[:custom_datetime] = "%d/%m/%Y"

#Configuracao para mostrar nos gráficos
Time::DATE_FORMATS[:custom_datetime_month_and_year] = "%m/%Y"
