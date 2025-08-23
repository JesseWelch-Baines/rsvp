class GuestGroups::SessionsController < ApplicationController
  before_action :find_guest_group, only: [:new, :create]
  
  def new; end

  def create
    if @guest_group.authenticate_passphrase(params[:session][:passphrase])
      # Sign in the guest group
      sign_in(:guest_group, @guest_group)
      redirect_to after_guest_group_sign_in_path(@guest_group)
    else
      flash.now[:alert] = 'Invalid passphrase'
      render :new
    end
  end

  def destroy
    sign_out(:guest_group)
    redirect_to root_path, notice: 'Signed out successfully'
  end

  private

  def find_guest_group
    @guest_group = GuestGroup.find_by(id: params[:guest_group_id])
  end
  
  def after_guest_group_sign_in_path(guest_group)
    # Customize this based on where you want to redirect guest groups
    root_path
  end
end
