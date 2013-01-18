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

ActiveRecord::Schema.define(:version => 20110208115628) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "commenter"
    t.string   "email"
    t.string   "website"
    t.text     "body"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "twitter"
    t.string   "avatar"
    t.boolean  "admin",       :default => false, :null => false
    t.string   "name"
    t.string   "title"
    t.string   "company"
    t.string   "contact"
    t.text     "description"
    t.text     "aboutus"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
    t.string   "website"
  end

  create_table "posts", :force => true do |t|
    t.integer  "member_id"
    t.integer  "category_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",   :default => false, :null => false
  end

end
