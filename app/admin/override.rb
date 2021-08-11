ActiveAdmin::Devise::SessionsController.class_eval do
  def root_path
    "/"  #add your logic
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end