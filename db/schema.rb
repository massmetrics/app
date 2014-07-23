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

ActiveRecord::Schema.define(version: 20140723201314) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.integer "product_id"
    t.string  "category"
  end

  add_index "categories", ["product_id"], name: "index_categories_on_product_id", using: :btree

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

  create_table "submissions", force: true do |t|
    t.string "sku"
    t.string "category"
  end

  create_table "users", force: true do |t|
    t.string   "email",                                            null: false
    t.string   "crypted_password",                                 null: false
    t.string   "salt",                                             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "role",                            default: "user"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

end
