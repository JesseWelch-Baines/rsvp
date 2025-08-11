class CreateGuestPreferences < ActiveRecord::Migration[8.0]
  def change
    create_table :preferences, id: :uuid do |t|
      t.references :guest, null: false, foreign_key: true, type: :uuid
      t.string :pref_type
      t.string :value

      t.timestamps
    end
  end
end
