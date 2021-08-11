ActiveAdmin.register Recipe do
  includes :ingredients, :products
  menu parent: 'Recipes'

  filter :products, as: :select, label: 'Ingredients'
  filter :name, filters: [:contains, :equals, :starts_with, :ends_with]  
  filter :description, filters: [:contains, :equals, :starts_with, :ends_with]  


  
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :steps, :picture
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :steps, :picture]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
