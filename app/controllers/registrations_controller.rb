class RegistrationsController < Devise::RegistrationsController
  def new_employee
    build_resource({})
    @validatable = devise_mapping.validatable?
    if @validatable
      @minimum_password_length = resource_class.password_length.min
    end
    render "welcome/add_employee"
  end

  def new
    @user = User.new
    render "welcome/signup_page"
  end

  def create
    build_resource(sign_up_params)
    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end
  end

  def create_employee
    build_resource(employee_sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        redirect_to root_path
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end
  end
  def cancel
    expire_data_after_sign_in!
    redirect_to new_registration_path(resource_name)
  end

  private

  def employee_sign_up_params
    params.require(:user).permit(:first_name, :last_name, :is_admin, :company_id, :email, :password, :password_confirmation)
  end

  def sign_up_params
    company = Company.create(name:params[:company_name])
    params[:user][:company_id] = company.id
    params.require(:user).permit(:first_name, :last_name, :is_admin, :company_id, :email, :password, :password_confirmation, :avatar)
  end

end
