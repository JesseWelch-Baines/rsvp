class GuestPreference < ApplicationRecord
  belongs_to :guest

  enum :pref_type, {
    attendance: "Attendance",
    dietary: "Dietary",
    playlist_request: "Playlist Request",
    message: "Message"
  }
end
