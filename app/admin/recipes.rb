ActiveAdmin.register Recipe do
  includes :ingredients, :products
  menu parent: 'Recipes'

  filter :products, as: :select, label: 'Ingredients'
  filter :name, filters: [:contains, :equals, :starts_with, :ends_with]  
  filter :description, filters: [:contains, :equals, :starts_with, :ends_with]  

  form do |f|
    f.inputs do
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

  
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :steps, :picture, ingredients_attributes: [:id, :amount, :measure, :product_id, :_destroy], products_attributes: [:name]
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :steps, :picture]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
