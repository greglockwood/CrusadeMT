class RenameSchoolTypeToType < ActiveRecord::Migration
  # changing this column name back to use Single Table Inheritance for schools
  def self.up
    rename_column :schools, :school_type, :type
  end

  def self.down
    rename_column :schools, :type, :school_type
  end
end
