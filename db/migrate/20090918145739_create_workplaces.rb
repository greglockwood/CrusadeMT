class CreateWorkplaces < ActiveRecord::Migration
  def self.up
    create_table :workplaces do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :suburb
      t.references :state
      t.string :post_code

      t.timestamps
    end
  end

  def self.down
    drop_table :workplaces
  end
end
