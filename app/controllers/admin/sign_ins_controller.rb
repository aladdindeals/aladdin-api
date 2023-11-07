class Admin::SignInsController < ApplicationController
  include Authentication

  # include Devise::Controllers::Rememberable

  skip_before_action :authenticate_user!
  before_action :set_user, except: [:new, :destroy]

  def new
    if request.format == :html
      render 'new'
    else
      head :no_content
    end
  end

  def create
    if @user.valid_password?(params[:password])
      sign_in_user
    else
      render 'new'
    end
  end

  def destroy
    current_user.update(emulated_user_id: nil, emulated_user_organization_id: nil)
    sign_out(current_user)
  end

  private

  def set_user
    @user = User.find_by("lower(email) = ?", params[:email]&.downcase) || User.find_by("phone_number = ?", params[:email]&.downcase)
    if @user.nil?
      flash[:error] = 'User not found'
      redirect_back(fallback_location: root_path)
    end
  end

  def sign_in_user
    sign_in(:user, @user)
    redirect_to after_sign_in_path_for(:user)
  end
end
