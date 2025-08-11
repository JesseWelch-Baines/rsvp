class CreateGuestGroupings < ActiveRecord::Migration[8.0]
  def change
    create_table :guest_groupings, id: :uuid do |t|
      t.references :guest, null: false, foreign_key: true, type: :uuid
      t.references :guest_group, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
