class Guest < ApplicationRecord
  has_many :guest_groupings, dependent: :destroy
  has_many :guest_groups, through: :guest_groupings

  validates :first_name, :last_name, presence: true

  def name
    "#{first_name} #{last_name}"
  end
end
