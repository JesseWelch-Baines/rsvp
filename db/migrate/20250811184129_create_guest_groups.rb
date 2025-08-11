class CreateGuestGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :guest_groups, id: :uuid do |t|
      t.string :passphrase

      t.timestamps
    end
  end
end
