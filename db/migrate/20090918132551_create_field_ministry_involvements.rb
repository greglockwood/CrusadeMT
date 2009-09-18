class CreateFieldMinistryInvolvements < ActiveRecord::Migration
  def self.up
    create_table :field_ministry_involvements do |t|
      t.references :field_ministry
      t.references :client
      t.date :start_date
      t.date :end_date
      t.boolean :became_christian

      t.timestamps
    end
  end

  def self.down
    drop_table :field_ministry_involvements
  end
end
