class CreateRevenue < ActiveRecord::Migration[5.2]
  def change
    create_table :revenues do |t|
      t.string :name
      t.boolean :fixed
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
