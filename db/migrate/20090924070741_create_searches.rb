class CreateSearches < ActiveRecord::Migration
  def self.up
    create_table :searches do |t|
      t.string :name
      t.string :first_name
      t.string :nickname
      t.string :last_name
      t.string :gender
      t.string :suburb
      t.boolean :christian
      t.boolean :became_christian
      t.integer :min_age
      t.integer :max_age
      t.boolean :has_children
      t.integer :oldest_child_age
      t.references :church

      t.timestamps
    end
    
    # insert the default "Everybody" search
    Search.create :name => "Everybody", 
                  :first_name => "",
                  :nickname => "",
                  :last_name => "",
                  :gender => "",
                  :suburb => "",
                  :christian => nil,
                  :became_christian => nil,
                  :min_age => nil,
                  :max_age => nil,
                  :has_children => nil,
                  :oldest_child_age => nil,
                  :church => nil
                  
  end

  def self.down
    drop_table :searches
  end
end
