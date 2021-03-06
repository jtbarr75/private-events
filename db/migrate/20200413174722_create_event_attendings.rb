class CreateEventAttendings < ActiveRecord::Migration[5.2]
  def change
    create_table :event_attendings do |t|
      t.references :attendee, foreign_key: true
      t.references :attended_event, foreign_key: true

      t.timestamps
    end
  end
end
