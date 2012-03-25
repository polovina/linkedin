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

ActiveRecord::Schema.define(:version => 20120322205719) do

  create_table "apikeys", :force => true do |t|
    t.string "token"
    t.string "secret"
  end

  create_table "boars", :force => true do |t|
    t.string   "title",          :default => "",       :null => false
    t.string   "rating",         :default => "0"
    t.string   "status",         :default => "novice"
    t.boolean  "active",         :default => true
    t.string   "comment",        :default => ""
    t.string   "source",         :default => ""
    t.string   "aliases",        :default => ""
    t.string   "hunter_id",                            :null => false
    t.string   "searched_by",    :default => ""
    t.string   "category",       :default => ""
    t.string   "crunchbase_url", :default => ""
    t.string   "seed_date",      :default => ""
    t.string   "A_date",         :default => ""
    t.string   "B_date",         :default => ""
    t.string   "C_date",         :default => ""
    t.string   "un_date",        :default => ""
    t.string   "employees",      :default => "0"
    t.string   "fund",           :default => ""
    t.string   "ceo",            :default => ""
    t.string   "cto",            :default => ""
    t.string   "founder",        :default => ""
    t.text     "overview",       :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

# Could not dump table "hunters" because of following StandardError
#   Unknown type '' for column 'email'

  create_table "shots", :force => true do |t|
    t.string   "boar"
    t.string   "hunter"
    t.string   "connection_first"
    t.string   "connection_first_url"
    t.string   "connection_second"
    t.string   "connection_second_url"
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

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
