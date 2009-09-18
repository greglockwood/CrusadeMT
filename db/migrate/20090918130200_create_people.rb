class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.boolean :christian
      t.references :church
      t.string :church_pastor
      t.integer :age
      t.integer :spouse_id
      t.references :workplace

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
