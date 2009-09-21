class AddPersonFields < ActiveRecord::Migration
  def self.up
    add_column :people, :parent_id, :integer
    add_column :people, :gender, :string, :limit => 7
    add_column :people, :nickname, :string
    add_column :people, :email, :string
    add_column :people, :phone, :string
    add_column :people, :mobile, :string
    add_column :people, :address1, :string
    add_column :people, :address2, :string
    add_column :people, :address3, :string
    add_column :people, :suburb, :string
    add_column :people, :state_id, :integer
    add_column :people, :postcode, :string, :limit => 4
    add_column :people, :date_of_birth, :date
  end

  def self.down                     
    remove_column :people, :parent_id
    remove_column :people, :gender
    remove_column :people, :nickname
    remove_column :people, :email
    remove_column :people, :phone
    remove_column :people, :mobile
    remove_column :people, :address1
    remove_column :people, :address2
    remove_column :people, :address3
    remove_column :people, :suburb
    remove_column :people, :state
    remove_column :people, :postcode
    remove_column :people, :date_of_birth
  end
end
