class CreateSearchInvolvements < ActiveRecord::Migration
  def self.up
    create_table :search_involvements do |t|
      t.references :search
      t.references :field_ministry

      t.timestamps
    end
    FieldMinistry.all.each do |ministry|
      SearchInvolvement.create(:search_id => 1, :field_ministry_id => ministry.id)
    end
  end

  def self.down
    drop_table :search_involvements
  end
end
