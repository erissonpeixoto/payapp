class AddFixedToExpenses < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :fixed, :boolean
  end
end
