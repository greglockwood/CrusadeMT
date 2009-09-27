class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.string :name
      t.string :description
      t.string :options
      t.string :value

      t.timestamps
    end
    # some initial settings to keep track of
    Setting.create  :name => "section_divider",
                    :description => "The type of divider used between logical groupings of information.",
                    :options => "horizontal_line blank_paragraph none",
                    :value => "horizontal_line"
                    
    Setting.create  :name => "show_text_when_field_is_blank",
                    :description => "Whether or not to show some text like 'N/A' or 'None' for fields with no information.",
                    :options => "yes no",
                    :value => "yes"
    Setting.create  :name => "show_unimplemented_features",
                    :description => "Whether or not unimplemented but planned features should show in the interface or not.",
                    :options => "yes no",
                    :value => "yes"


                    
  end

  def self.down
    drop_table :settings
  end
end
