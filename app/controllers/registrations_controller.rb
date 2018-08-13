class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit( :name,
                                  :email,
                                  :password,
                                  :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit( :name,
                                  :email,
                                  :password,
                                  :password_confirmation,
                                  :current_password,
                                  :avatar)
  end
  def update_resource(resource, params)
    if(params[:password].empty?)
      resource.update_without_password(params.except(:password, :current_password, :password_confirmation))
    else 
      resource.update_with_password(params)
    end
  end
end
