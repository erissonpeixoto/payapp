class AddUserToConfiguration < ActiveRecord::Migration[5.2]
  def change
    add_column :configurations, :user_id, :integer
  end
end
