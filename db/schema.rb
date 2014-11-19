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

ActiveRecord::Schema.define(version: 20141119043816) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", force: true do |t|
    t.integer  "requester_id"
    t.integer  "accepter_id"
    t.integer  "admin_id"
    t.boolean  "availability"
    t.integer  "shift_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "reason"
    t.boolean  "pending",      default: true
  end

  create_table "shift_templates", force: true do |t|
    t.integer  "start_time"
    t.integer  "end_time"
    t.integer  "company_id"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shifts", force: true do |t|
    t.integer  "admin_id"
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
    t.integer  "shift_template_id"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_admin"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
