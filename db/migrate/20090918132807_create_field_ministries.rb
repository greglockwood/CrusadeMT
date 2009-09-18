class CreateFieldMinistries < ActiveRecord::Migration
  def self.up
    create_table :field_ministries do |t|
      t.string :name
      t.string :xml_url

      t.timestamps
    end
  end

  def self.down
    drop_table :field_ministries
  end
end
