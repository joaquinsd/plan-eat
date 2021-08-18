ActiveAdmin.register Order do
  includes :products, :order_items

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :number, :total, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :number, :total, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
