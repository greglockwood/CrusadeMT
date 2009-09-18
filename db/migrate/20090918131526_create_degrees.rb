class CreateDegrees < ActiveRecord::Migration
  def self.up
    create_table :degrees do |t|
      t.references :person
      t.string :name
      t.integer :university_id

      t.timestamps
    end
  end

  def self.down
    drop_table :degrees
  end
end
