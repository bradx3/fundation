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

ActiveRecord::Schema.define(:version => 20110411074443) do

  create_table "deposit_template_fund_percentages", :force => true do |t|
    t.integer  "deposit_template_id"
    t.integer  "fund_id"
    t.float    "percentage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deposit_templates", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default"
  end

  create_table "families", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fund_transactions", :force => true do |t|
    t.integer  "transaction_id"
    t.integer  "fund_id"
    t.float    "percentage"
    t.float    "amount_in_cents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "funds", :force => true do |t|
    t.string   "name"
    t.float    "initial_balance_in_cents", :default => 0.0
    t.boolean  "default_synchronize_fund", :default => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",                 :default => false
  end

  create_table "transactions", :force => true do |t|
    t.string   "type"
    t.integer  "amount_in_cents"
    t.integer  "user_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                              :null => false
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.integer  "family_id"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
