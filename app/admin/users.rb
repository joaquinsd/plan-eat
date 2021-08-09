ActiveAdmin.register User do
  menu parent: 'Admins & Users'

# includes :recipes, :ingredients, :products
permit_params :email, :name, :lastname, :profile_picture

index do
  column :id
  column :name
  column :lastname
  column :email
  column :profile_picture
  column :created_at
  actions
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