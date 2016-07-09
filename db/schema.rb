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

ActiveRecord::Schema.define(version: 20160709153247) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "payment_infos", force: :cascade do |t|
    t.integer  "rent_id"
    t.string   "merchant_id"
    t.string   "total"
    t.string   "trade_no"
    t.string   "merchant_order_no"
    t.string   "check_code"
    t.string   "ip"
    t.string   "payment_type"
    t.string   "pay_time"
    t.string   "card_6no"
    t.string   "card_4no"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "payment_infos", ["rent_id"], name: "index_payment_infos_on_rent_id", using: :btree

  create_table "rents", force: :cascade do |t|
    t.string   "token"
    t.string   "receipt_num"
    t.integer  "pay_state",      default: 0
    t.integer  "total"
    t.string   "payment_method"
    t.string   "house_name"
    t.string   "room_name"
    t.string   "billing_mail"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_foreign_key "payment_infos", "rents"
end
