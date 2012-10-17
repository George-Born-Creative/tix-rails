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

ActiveRecord::Schema.define(:version => 20121017135151) do

  create_table "accounts", :force => true do |t|
    t.string   "subdomain",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "accounts", ["subdomain"], :name => "index_accounts_on_subdomain", :unique => true

  create_table "addresses", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "addressable_id",   :null => false
    t.string   "addressable_type", :null => false
    t.string   "tag_for_address"
    t.string   "country"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "locality"
    t.string   "admin_area"
    t.string   "postal_code"
  end

  add_index "addresses", ["address_line_1"], :name => "index_addresses_on_address_line_1"
  add_index "addresses", ["postal_code"], :name => "index_addresses_on_postal_code"

  create_table "area_seats", :force => true do |t|
    t.string "polypath"
    t.string "label"
  end

  create_table "areas", :force => true do |t|
    t.string  "label"
    t.string  "label_section"
    t.string  "polypath"
    t.decimal "x"
    t.decimal "y"
    t.integer "stack_order",   :default => 0
    t.integer "chart_id"
    t.string  "type"
    t.integer "section_id"
    t.decimal "cx"
    t.decimal "cy"
    t.decimal "r"
    t.decimal "width"
    t.decimal "height"
    t.string  "transform"
    t.string  "points"
    t.integer "max_tickets",   :default => 1, :null => false
  end

  add_index "areas", ["section_id"], :name => "index_areas_on_section_id"

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
    t.text     "youtube1"
    t.text     "youtube2"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.decimal  "id_old"
    t.integer  "account_id",              :default => 0, :null => false
    t.integer  "id_old_image"
    t.string   "audio_sample_title"
    t.integer  "artist_id_old_secondary"
  end

  create_table "carousel_items", :force => true do |t|
    t.string   "title"
    t.string   "caption"
    t.string   "link"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "carousels", :force => true do |t|
    t.string   "slug"
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "charts", :force => true do |t|
    t.string   "name"
    t.string   "background_image_url"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "account_id",             :default => 0,     :null => false
    t.string   "label"
    t.string   "svg_file_file_name"
    t.string   "svg_file_content_type"
    t.integer  "svg_file_file_size"
    t.datetime "svg_file_updated_at"
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
    t.text     "svg_file_serialized"
    t.decimal  "width"
    t.decimal  "height"
    t.string   "background_color"
    t.boolean  "master",                 :default => false
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "account_id"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "customer_imports", :force => true do |t|
    t.integer  "account_id"
    t.string   "state"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "events", :force => true do |t|
    t.string   "title"
    t.string   "headline"
    t.text     "supporting_act"
    t.text     "body"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "chart_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "headliner_id"
    t.integer  "secondary_headliner_id"
    t.string   "supporting_act_1"
    t.string   "supporting_act_2"
    t.string   "supporting_act_3"
    t.text     "info"
    t.text     "set_times"
    t.string   "price_freeform"
    t.integer  "account_id",             :default => 0, :null => false
    t.string   "chart"
    t.integer  "artist_id_old"
    t.string   "cat"
    t.datetime "announce_at"
    t.datetime "on_sale_at"
    t.datetime "off_sale_at"
    t.datetime "remove_at"
    t.string   "buytix_url_old"
    t.string   "slug"
  end

  create_table "events_supporting_acts", :force => true do |t|
    t.integer "event_id"
    t.integer "artist_id"
  end

  create_table "images", :force => true do |t|
    t.string   "title"
    t.string   "caption"
    t.string   "type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "account_id"
  end

  create_table "orders", :force => true do |t|
    t.string   "status",                                       :default => "pending", :null => false
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.integer  "account_id",                                   :default => 0,         :null => false
    t.integer  "user_id"
    t.decimal  "total",          :precision => 8, :scale => 2, :default => 0.0,       :null => false
    t.decimal  "tax",            :precision => 8, :scale => 2, :default => 0.0,       :null => false
    t.decimal  "service_charge", :precision => 8, :scale => 2, :default => 0.0,       :null => false
    t.string   "state",                                        :default => "cart"
  end

  add_index "orders", ["status"], :name => "index_orders_on_status"
  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "pages", :force => true do |t|
    t.string   "slug",       :null => false
    t.string   "title",      :null => false
    t.text     "body"
    t.integer  "account_id"
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.decimal  "sidebar_id"
  end

  create_table "phones", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "phonable_id",   :null => false
    t.string   "phonable_type", :null => false
    t.string   "tag_for_phone"
    t.string   "number"
    t.string   "country_code"
    t.string   "locality_code"
    t.string   "local_number"
  end

  add_index "phones", ["number"], :name => "index_phones_on_number"

  create_table "prices", :force => true do |t|
    t.string   "label"
    t.decimal  "base",       :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.decimal  "service",    :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.decimal  "tax",        :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.integer  "account_id"
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
  end

  create_table "seating_charts", :force => true do |t|
    t.string   "name"
    t.string   "background_image_url"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "sections", :force => true do |t|
    t.string   "label"
    t.decimal  "default_base_price",     :precision => 8, :scale => 2, :default => 0.0,   :null => false
    t.decimal  "default_service_charge", :precision => 8, :scale => 2, :default => 0.0,   :null => false
    t.integer  "chart_id"
    t.datetime "created_at",                                                              :null => false
    t.datetime "updated_at",                                                              :null => false
    t.boolean  "seatable",                                             :default => false, :null => false
    t.string   "color"
    t.integer  "dayof_price_id"
    t.integer  "presale_price_id"
  end

  create_table "sidebars", :force => true do |t|
    t.string   "slug"
    t.string   "title"
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "single_seats", :force => true do |t|
    t.string  "label"
    t.decimal "x",                :default => 0.0, :null => false
    t.decimal "y",                :default => 0.0, :null => false
    t.integer "seating_chart_id"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "themes", :force => true do |t|
    t.string   "title"
    t.text     "css_doc"
    t.datetime "activated_at"
    t.integer  "account_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "background_image_file_name"
    t.string   "background_image_content_type"
    t.integer  "background_image_file_size"
    t.datetime "background_image_updated_at"
  end

  create_table "ticket_templates", :force => true do |t|
    t.string   "label"
    t.string   "meta"
    t.integer  "times_used",        :default => 0, :null => false
    t.integer  "account_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "tickets", :force => true do |t|
    t.decimal  "price"
    t.string   "state",                         :null => false
    t.integer  "event_id"
    t.integer  "area_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "order_id"
    t.integer  "account_id",     :default => 0, :null => false
    t.decimal  "base_price"
    t.decimal  "service_charge"
    t.string   "area_label"
    t.string   "section_label"
    t.datetime "checked_in_at"
    t.string   "status"
  end

  add_index "tickets", ["state"], :name => "index_tickets_on_state"

  create_table "users", :force => true do |t|
    t.string   "email",                                                :default => "",         :null => false
    t.string   "encrypted_password",                                   :default => "",         :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                                   :null => false
    t.datetime "updated_at",                                                                   :null => false
    t.integer  "account_id",                                           :default => 0,          :null => false
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "salutation"
    t.string   "title"
    t.string   "role",                                                 :default => "customer"
    t.decimal  "balance",                :precision => 8, :scale => 2, :default => 0.0,        :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                                      :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["first_name"], :name => "index_users_on_first_name"
  add_index "users", ["last_name"], :name => "index_users_on_last_name"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["role"], :name => "index_users_on_role"

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "widget_placements", :force => true do |t|
    t.integer  "sidebar_id"
    t.integer  "widget_id"
    t.integer  "account_id"
    t.integer  "index"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "widgets", :force => true do |t|
    t.string   "slug"
    t.string   "title"
    t.integer  "account_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
