class CreateRecipeMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_menus do |t|
      t.references :recipe, foreign_key: true
      t.references :menu, foreign_key: true

      t.timestamps
    end
  end
end
