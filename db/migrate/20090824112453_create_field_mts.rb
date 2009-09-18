class CreateFieldMTs < ActiveRecord::Migration
  def self.up
    create_table :field_mts do |t|
      t.string :Name
      t.string :URL
      t.datetime :date_added

      t.timestamps
    end
  end

  def self.down
    drop_table :field_mts
  end
end
