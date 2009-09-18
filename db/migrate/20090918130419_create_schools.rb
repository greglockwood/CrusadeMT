class CreateSchools < ActiveRecord::Migration
  def self.up
    create_table :schools do |t|
      t.string :name
      t.string :type
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :suburb
      t.references :state
      t.string :postcode, :limit => 4

      t.timestamps
    end
  end

  def self.down
    drop_table :schools
  end
end
