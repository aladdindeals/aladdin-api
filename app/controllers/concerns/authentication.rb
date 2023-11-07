module Authentication
  extend ActiveSupport::Concern
  included do
    before_action :authenticate_user!
  end

  protected

  def authenticate_user!(options = {})
    if user_signed_in?
      super(options)
    else
      store_user_location! if storable_location?
      redirect_to root_path, notice: 'You have to sign in before accessing this page.'
    end
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr? && !is_a?(Admin::SignInsController)
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def after_sign_in_path_for(resource)
    if @user.present?
      user_root_path
    else
      request.env['omniauth.origin'] || stored_location_for(resource) || user_root_path
    end
  end

end