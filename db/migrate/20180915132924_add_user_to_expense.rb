class AddUserToExpense < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :user_id, :integer
  end
end
