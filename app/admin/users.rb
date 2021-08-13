ActiveAdmin.register User do
  menu parent: 'Admins & Users'

 includes :recipes
permit_params :email, :name, :lastname, :profile_picture, :role

index do
  column :id
  column :name
  column :lastname
  column :email
  column :profile_picture
  column :role
  column :created_at
  column 'Favorite Recipes', :recipes
  actions
end

show do
  attributes_table do
    row :name
    row :lastname
    row :email
    row :role
    row('Favorite Recipes'){ |r| r.recipes}
    row :created_at
  end
  active_admin_comments
end

form do |f|
  f.inputs do
    f.input :email
    f.input :name
    f.input :lastname
    f.input :profile_picture
    f.input :password
    f.input :password_confirmation
    f.input :role
  end
  f.actions
end

end