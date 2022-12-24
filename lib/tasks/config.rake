namespace :config do
  desc "Seta usuário inicial nos cadastros já existentes"
  task set_user_initial: :environment do
    user = User.first

    Configuration.all.each do |config|
      config.user = user
      config.save
    end

    Category.all.each do |category|
      category.user = user
      category.save
    end

    Expense.all.each do |expense|
      expense.user = user
      expense.save
    end

    Payment.all.each do |payment|
      payment.user = user
      payment.save
    end

    puts "Usuário foi setado em todas as tabelas no ambiente: #{Rails.env}"
  end

end
