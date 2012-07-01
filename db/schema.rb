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

ActiveRecord::Schema.define(:version => 20120701164215) do

  create_table "area_seats", :force => true do |t|
    t.string  "polypath"
    t.string  "label"
    t.decimal "default_price"
    t.integer "seating_chart_id"
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.string   "headline"
    t.text     "supporting_act"
    t.string   "image_uri"
    t.string   "image_thumb_uri"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "seating_chart_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.text     "body"
  end

  create_table "seating_charts", :force => true do |t|
    t.string   "name"
    t.string   "background_image_url"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "single_seats", :force => true do |t|
    t.string  "label"
    t.decimal "x"
    t.decimal "y"
    t.integer "seating_chart_id"
    t.decimal "default_price"
  end

end
