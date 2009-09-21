class RenameWorkplacePostCodeField < ActiveRecord::Migration
  # To fix an inconsistency with workplaces postcode column name.
  # Needs to be consistent to benefit from the Shared::FullAddress module
  def self.up
    rename_column :workplaces, :post_code, :postcode
  end

  def self.down
    rename_column :workplaces, :postcode, :post_code
  end
end
