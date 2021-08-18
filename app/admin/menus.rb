ActiveAdmin.register Menu do
  includes :recipes, :users, :recipe_menus
  menu parent: 'Recipes'

  permit_params :title, :members, :category, recipe_menus_attributes: [:id, :recipe_id, :_destroy], recipe_attributes: [:name]

  form do |f|
    f.inputs do
      f.input :title
      f.input :members
      f.has_many :recipe_menus, heading: 'Recipes',
                            allow_destroy: true,
                            new_record: true do |a|
        a.input :recipe_id, as: :select, collection: Recipe.all.map { |w| [w.name, w.id.to_i] }.uniq.sort, :wrapper_html => { :class => 'fl' }
      end
      f.input :category, as: :select, collection: Menu.select(:category).map(&:category).uniq.sort, :wrapper_html => { :class => 'fl' }
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :members
      row :category
      row('Recipes'){ |r| r.recipes}
      row :created_at
    end
    active_admin_comments
  end

  
end
