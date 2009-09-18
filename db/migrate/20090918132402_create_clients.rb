class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.references :person

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
