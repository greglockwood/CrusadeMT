class CreateEnrolments < ActiveRecord::Migration
  def self.up
    create_table :enrolments do |t|
      t.references :person
      t.references :degree
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end

  def self.down
    drop_table :enrolments
  end
end
