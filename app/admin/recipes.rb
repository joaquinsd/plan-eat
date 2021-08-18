ActiveAdmin.register Recipe do
  includes :ingredients, :products
  menu parent: 'Recipes'

  filter :products, as: :select, label: 'Ingredients'
  filter :name, filters: [:contains, :equals, :starts_with, :ends_with]  
  filter :description, filters: [:contains, :equals, :starts_with, :ends_with]  
  filter :category, as: :select, label: 'Categories'

  form do |f|
    f.inputs do
      f.semantic_errors *f.object.errors.keys
      f.input :name
      f.input :description
      f.has_many :ingredients, heading: 'Ingredients',
                            allow_destroy: true,
                            new_record: true do |a|
        a.input :product_id, as: :select, collection: Product.all.map { |w| [w.name, w.id.to_i] }.uniq.sort, :wrapper_html => { :class => 'fl' }
        a.input :amount, :wrapper_html => { :class => 'fl' }
        a.input :measure, as: :select, collection: Ingredient.select(:measure).map(&:measure).uniq.sort, :wrapper_html => { :class => 'fl' }
      end
      f.input :steps
      f.input :picture
      f.input :category, as: :select, collection: Recipe.select(:category).map(&:category).uniq.sort
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :steps
      row('Ingredients'){ |r| r.products}
      row :created_at
    end
    active_admin_comments
  end

  permit_params :name, :description, :steps, :picture, :category, ingredients_attributes: [:id, :amount, :measure, :product_id,:_destroy], products_attributes: [:name]
end
