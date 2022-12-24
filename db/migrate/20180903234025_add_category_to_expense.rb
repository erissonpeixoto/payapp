class AddCategoryToExpense < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :category_id, :integer
  end
end
