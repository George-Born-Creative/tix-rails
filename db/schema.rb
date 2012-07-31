# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120731142317) do

  create_table "areas", :force => true do |t|
    t.string  "label"
    t.string  "label_section"
    t.string  "polypath"
    t.decimal "x"
    t.decimal "y"
    t.integer "stack_order",   :default => 0
    t.integer "chart_id"
    t.string  "type"
  end

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.text     "body"
    t.text     "description"
    t.string   "url"
    t.string   "myspace_url"
    t.string   "facebook_url"
    t.string   "audio_sample_url"
    t.string   "video_url"
    t.string   "twitter"
    t.string   "youtube1"
    t.string   "youtube2"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.decimal  "id_old"
  end

  create_table "charts", :force => true do |t|
    t.string   "name"
    t.string   "background_image_url"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.string   "headline"
    t.text     "supporting_act"
    t.text     "body"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "chart_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "headliner_id"
    t.integer  "secondary_headliner_id"
    t.string   "supporting_act_1"
    t.string   "supporting_act_2"
    t.string   "supporting_act_3"
    t.text     "info"
    t.text     "set_times"
    t.string   "price_freeform"
  end

  create_table "orders", :force => true do |t|
    t.string   "status",     :default => "pending", :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "orders", ["status"], :name => "index_orders_on_status"

  create_table "tickets", :force => true do |t|
    t.decimal  "price"
    t.string   "state",      :default => "open", :null => false
    t.integer  "event_id"
    t.integer  "area_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "order_id"
  end

  add_index "tickets", ["state"], :name => "index_tickets_on_state"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
