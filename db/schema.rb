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

ActiveRecord::Schema.define(:version => 20120316180606) do

  create_table "apikeys", :force => true do |t|
    t.string "token"
    t.string "secret"
  end

  create_table "boars", :force => true do |t|
    t.string   "title"
    t.string   "rating"
    t.string   "status"
    t.boolean  "active"
    t.text     "description"
    t.string   "comment"
    t.string   "source"
    t.string   "aliases"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hunters", :force => true do |t|
    t.string   "name"
    t.string   "token"
    t.string   "secret"
    t.string   "linked_id"
    t.string   "image_url"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shots", :force => true do |t|
    t.string   "boar"
    t.string   "hunter"
    t.string   "connection_first"
    t.string   "connection_second"
    t.string   "headline"
    t.string   "source"
    t.string   "comments"
    t.boolean  "important"
    t.string   "hunter_id"
    t.string   "boar_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.string   "task"
    t.string   "frequency"
    t.boolean  "active"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
