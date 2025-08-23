class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_any!
  before_action :set_current_user

  protected

  # Authentication helpers
  def authenticate_any!
    return if (params[:controller] == 'devise/sessions' || params[:controller] == 'guest_groups/sessions') &&
      (params[:action] == 'new' || params[:action] == 'create')

    unless user_signed_in? || guest_group_signed_in?
      redirect_to new_user_session_path, alert: 'Please sign in to continue'
    end
  end

  # Specific authentication checks
  def admin_signed_in?
    user_signed_in?
  end

  def guest_group_signed_in?
    current_guest_group.present?
  end

  def current_guest_group
    warden.user(:guest_group)
  end

  private

  def set_current_user
    Current.user = current_user if current_user.present?
  end
end
