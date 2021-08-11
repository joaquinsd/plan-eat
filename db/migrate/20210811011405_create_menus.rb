class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :title
      t.integer :members
      t.string :category

      t.timestamps
    end
  end
end
