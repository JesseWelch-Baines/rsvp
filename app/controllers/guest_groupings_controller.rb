class GuestGroupingsController < ApplicationController
  def new
    guest_group = GuestGroup.find_by(id: params[:guest_group_id]) || GuestGroup.new
    guest_group.guest_groupings.clear

    guest_ids = params[:guest_ids] || []
    guest_ids.each do |guest_id|
      guest_group.guest_groupings.build(guest_id: guest_id)
    end

    ungrouped_guests = Guest.where.not(id: guest_ids)

    render turbo_stream: turbo_stream.replace(
      "guest_groupings_form",
      partial: "/guest_groups/guest_groupings_form",
      locals: { guest_group: guest_group, ungrouped_guests: ungrouped_guests }
    )
  end
end
