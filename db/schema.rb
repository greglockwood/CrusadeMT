# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090927160101) do

  create_table "churches", :force => true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "suburb"
    t.integer  "state_id"
    t.string   "postcode",   :limit => 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "degrees", :force => true do |t|
    t.integer  "person_id"
    t.string   "name"
    t.integer  "university_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enrolments", :force => true do |t|
    t.integer  "person_id"
    t.integer  "degree_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "field_ministries", :force => true do |t|
    t.string   "name"
    t.string   "xml_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "field_ministry_involvements", :force => true do |t|
    t.integer  "field_ministry_id"
    t.integer  "client_id"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "became_christian"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "life_events", :force => true do |t|
    t.integer  "person_id"
    t.string   "description"
    t.date     "event_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.boolean  "christian"
    t.integer  "church_id"
    t.string   "church_pastor"
    t.integer  "age"
    t.integer  "spouse_id"
    t.integer  "workplace_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.string   "gender",        :limit => 7
    t.string   "nickname"
    t.string   "email"
    t.string   "phone"
    t.string   "mobile"
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "suburb"
    t.integer  "state_id"
    t.string   "postcode",      :limit => 4
    t.date     "date_of_birth"
  end

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "suburb"
    t.integer  "state_id"
    t.string   "postcode",   :limit => 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_involvements", :force => true do |t|
    t.integer  "search_id"
    t.integer  "field_ministry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", :force => true do |t|
    t.string   "name"
    t.string   "first_name"
    t.string   "nickname"
    t.string   "last_name"
    t.string   "gender"
    t.string   "suburb"
    t.boolean  "christian"
    t.boolean  "became_christian"
    t.integer  "min_age"
    t.integer  "max_age"
    t.boolean  "has_children"
    t.integer  "oldest_child_age"
    t.integer  "church_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "settings", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "options"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", :force => true do |t|
    t.integer  "person_id"
    t.integer  "school_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workplaces", :force => true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "suburb"
    t.integer  "state_id"
    t.string   "postcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
