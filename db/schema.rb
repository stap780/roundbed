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

ActiveRecord::Schema.define(version: 20210408153302) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alviteks", force: :cascade do |t|
    t.string   "aid"
    t.string   "sku"
    t.string   "title"
    t.string   "desc"
    t.string   "qt"
    t.decimal  "price"
    t.decimal  "mprice"
    t.string   "image"
    t.string   "cat"
    t.string   "col"
    t.string   "vendor"
    t.string   "country"
    t.string   "line"
    t.string   "razmer"
    t.string   "teplota"
    t.string   "podderjka"
    t.string   "razm_nav"
    t.string   "razm_podod"
    t.string   "razmer_prostini"
    t.string   "tip_prostini"
    t.string   "visota"
    t.string   "napolnitel"
    t.string   "napolnitel_chehla"
    t.string   "napolnitel_yadra"
    t.string   "ves_napolnitel"
    t.string   "ves_nopolnitel_chehla"
    t.string   "ves_napolnitel_yadra"
    t.string   "tkan"
    t.string   "sostav_tkan"
    t.string   "tip_zast"
    t.string   "tip_zast_navol"
    t.string   "tip_zast_podod"
    t.string   "tip_krepl"
    t.string   "tip_stejki"
    t.string   "okantovka"
    t.string   "upak"
    t.string   "tip_upak"
    t.string   "kol_upak"
    t.string   "material"
    t.string   "plotnost"
    t.string   "barcode"
    t.string   "cvet"
    t.string   "tkan_verh"
    t.string   "tkan_niz"
    t.string   "sostav"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "asabs", force: :cascade do |t|
    t.string   "aid"
    t.string   "sku"
    t.string   "title"
    t.string   "sdesc"
    t.string   "desc"
    t.decimal  "cprice"
    t.decimal  "price"
    t.string   "qt"
    t.string   "image"
    t.string   "sostav"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bests", force: :cascade do |t|
    t.string   "sku"
    t.string   "title"
    t.string   "sdesc"
    t.string   "desc"
    t.decimal  "cprice"
    t.decimal  "price"
    t.string   "qt"
    t.string   "image"
    t.string   "sv_razmer"
    t.string   "p_razmer"
    t.string   "p_napolnit"
    t.string   "p_visota"
    t.string   "p_dlina"
    t.string   "p_shirina"
    t.string   "p_ves"
    t.string   "p_sostav"
    t.string   "p_osoben"
    t.string   "p_tipmatrasa"
    t.string   "p_garant"
    t.string   "p_forma"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "sv_chehol"
  end

  create_table "cleos", force: :cascade do |t|
    t.string   "sku"
    t.string   "title"
    t.string   "sdesc"
    t.string   "desc"
    t.decimal  "cprice"
    t.decimal  "price"
    t.string   "qt"
    t.string   "image"
    t.string   "barcode"
    t.string   "dizain"
    t.string   "cvet"
    t.string   "tema"
    t.string   "okras"
    t.string   "otdelka"
    t.string   "zast"
    t.string   "kvopred"
    t.string   "tkan"
    t.string   "plotnost"
    t.string   "sostav"
    t.string   "obrazmer"
    t.string   "pr_razmer"
    t.string   "obem"
    t.string   "ves"
    t.string   "razmer_upak"
    t.string   "vid_upak"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "evateks", force: :cascade do |t|
    t.string   "eid"
    t.string   "url"
    t.string   "title"
    t.string   "sku"
    t.decimal  "cprice"
    t.string   "sdesc"
    t.string   "desc"
    t.decimal  "price"
    t.decimal  "oprice"
    t.string   "qt"
    t.string   "razmer_eu"
    t.string   "razmer_ru"
    t.string   "uzor"
    t.string   "cvet"
    t.string   "sostav"
    t.string   "weight"
    t.string   "vendor"
    t.string   "col"
    t.string   "country"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "homes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "infas", force: :cascade do |t|
    t.string   "fid"
    t.string   "sku"
    t.string   "barcode"
    t.string   "title"
    t.string   "desc"
    t.string   "feature"
    t.decimal  "costprice"
    t.decimal  "price"
    t.string   "qt"
    t.string   "image"
    t.string   "vendor"
    t.string   "model"
    t.string   "i_param"
    t.string   "cat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "laetes", force: :cascade do |t|
    t.string   "lid"
    t.string   "url"
    t.string   "title"
    t.string   "sku"
    t.decimal  "price"
    t.string   "qt"
    t.string   "razmer_eu"
    t.string   "razmer_ru"
    t.string   "uzor"
    t.string   "cvet"
    t.string   "sostav"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal  "cprice"
    t.decimal  "oprice"
    t.string   "sdesc"
    t.string   "desc"
  end

  create_table "marcs", force: :cascade do |t|
    t.string   "sku"
    t.string   "title"
    t.string   "sdesc"
    t.string   "desc"
    t.decimal  "cprice"
    t.decimal  "price"
    t.string   "qt"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "razmer"
    t.string   "cvet"
    t.string   "razmer2"
    t.string   "sostav"
    t.string   "url"
  end

  create_table "permcl_actions", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permcls", force: :cascade do |t|
    t.string   "systitle"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "permcl_id"
    t.integer  "permcl_action_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "role"
  end

end
