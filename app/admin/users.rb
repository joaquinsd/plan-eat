ActiveAdmin.register User do
  menu parent: 'Admins & Users'

  includes :recipes, :menus
  permit_params :email, :name, :lastname, :profile_picture, :role

  filter :recipes, as: :select, label: 'Recipes'
  filter :menus, as: :select, label: 'Menus'
  filter :name, filters: %i[contains equals starts_with ends_with]
  filter :lastname, filters: %i[contains equals starts_with ends_with]
  filter :email, filters: %i[contains equals starts_with ends_with]
  filter :role, filters: %i[contains equals starts_with ends_with]

  index do
    column :id
    column :name
    column :lastname
    column :email
    column "Profile Picture" do |picture|
      truncate(picture.profile_picture, omision: "...", length: 80)
    end
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