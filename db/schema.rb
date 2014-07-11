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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140711190646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "price_logs", force: true do |t|
    t.string   "price"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "price_logs", ["product_id"], name: "index_price_logs_on_product_id", using: :btree

  create_table "products", force: true do |t|
    t.string "sku"
    t.string "detail_page_url"
    t.string "review_url"
    t.string "title"
    t.text   "features"
    t.string "current_price"
    t.string "large_image_url"
    t.string "small_image_url"
    t.string "medium_image_url"
    t.string "brand"
    t.text   "description"
  end

end
