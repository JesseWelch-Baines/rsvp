class GuestGroup < ApplicationRecord
  has_many :guest_groupings, dependent: :destroy
  has_many :guests, through: :guest_groupings

  validates :passphrase, presence: true

  accepts_nested_attributes_for :guest_groupings, allow_destroy: true

  after_initialize :set_default_passphrase, if: :new_record?

  def guest_names
    guests.any? ? guests.pluck(:first_name).join(", ") : "No guests"
  end

  private

  def set_default_passphrase
    self.passphrase ||= (0...4).map { (65 + rand(26)).chr }.join
  end
end
