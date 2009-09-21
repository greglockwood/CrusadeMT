class RenameSchoolTypeColumn < ActiveRecord::Migration
  def self.up
    rename_column :schools, :type, :school_type
  end

  def self.down
    rename_column :schools, :school_type, :type
  end
end
