class CreateLifeEvents < ActiveRecord::Migration
  def self.up
    create_table :life_events do |t|
      t.references :person
      t.string :description
      t.date :event_date

      t.timestamps
    end
  end

  def self.down
    drop_table :life_events
  end
end
