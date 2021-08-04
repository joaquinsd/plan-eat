class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.references :recipe, foreign_key: true
      t.references :product, foreign_key: true
      t.float :amount
      t.string :measure

      t.timestamps
    end
  end
end
