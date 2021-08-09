ActiveAdmin.register Ingredient do
  menu parent: 'Recipes'
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  #  permit_params :amount, :measure
  #
  # or
  #
  permit_params do
    if params[:action] == 'create'
      permitted = [:recipe_id, :product_id, :amount, :measure]
      permitted << :other if current_user.admin?
    else 
      permitted = [:amount, :measure]
    end
    permitted
  end
  
end
