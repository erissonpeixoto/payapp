class CreateConfigurations < ActiveRecord::Migration[5.2]
  def change
    create_table :configurations do |t|
      t.decimal :salary

      t.timestamps
    end
  end
end
