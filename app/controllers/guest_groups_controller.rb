class GuestGroupsController < ApplicationController
  def index
    @guest_groups = GuestGroup.all
  end

  def show
    @guest_group = GuestGroup.find(params[:id])
  end

  def new
    @guest_group = GuestGroup.new

    @ungrouped_guests = Guest.all
  end

  def create
    @guest_group = GuestGroup.new(guest_group_params)
    if @guest_group.save
      redirect_to guest_groups_path, notice: 'Guest group was successfully created.'
    else
      render :new
    end
  end

  def edit
    @guest_group = GuestGroup.find(params[:id])

    @ungrouped_guests = Guest.all - @guest_group.guests
  end

  def update
    @guest_group = GuestGroup.find(params[:id])

    if @guest_group.update(guest_group_params)
      redirect_to guest_groups_path, notice: 'Guest group was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @guest_group = GuestGroup.find(params[:id])
    @guest_group.destroy
    redirect_to guest_groups_path
  end

  private

  def guest_group_params
    params.require(:guest_group).permit(:name, guest_groupings_attributes: [:id, :guest_id])
  end
end
