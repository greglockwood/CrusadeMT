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
                    :description => "The type of divider used between logical groupings of information. 'Horizontal Line' is a green line across the whole content area, 'Blank Paragraph' shows a blank paragraph instead, and 'None' hides dividers altogether.",
                    :options => "horizontal_line blank_paragraph none",
                    :value => "horizontal_line"
                    
    Setting.create  :name => "show_text_when_field_is_blank",
                    :description => "Whether or not to show some text like 'N/A' or 'None' for fields with no information. 'Yes' shows the blank text, 'No' shows only a non-breaking space.",
                    :options => "yes no",
                    :value => "yes"
    Setting.create  :name => "show_unimplemented_features",
                    :description => "Whether or not unimplemented but planned features should show in the interface or not. 'Yes' means they show as normal, 'Disabled' shows them but greyed out and makes form fields disabled, 'No' hides them altogether.",
                    :options => "yes disabled no",
                    :value => "disabled"


                    
  end

  def self.down
    drop_table :settings
  end
end
