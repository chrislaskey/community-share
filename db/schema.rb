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

ActiveRecord::Schema.define(version: 20170218190205) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "communities", force: :cascade do |t|
    t.boolean  "read_only"
    t.integer  "uid"
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["uid"], name: "index_communities_on_uid", using: :btree
  end

  create_table "community_levels", force: :cascade do |t|
    t.string  "name"
    t.string  "slug"
    t.integer "file_count_limit"
    t.bigint  "file_size_limit"
    t.integer "membership_count_limit"
    t.integer "tag_count_limit"
    t.index ["slug"], name: "index_community_levels_on_slug", using: :btree
  end

  create_table "community_subscriptions", force: :cascade do |t|
    t.integer  "community_id"
    t.integer  "community_level_id"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["community_id", "community_level_id"], name: "index_subscriptions_by_community_and_level", using: :btree
    t.index ["community_id"], name: "index_community_subscriptions_on_community_id", using: :btree
    t.index ["community_level_id"], name: "index_community_subscriptions_on_community_level_id", using: :btree
    t.index ["ended_at"], name: "index_community_subscriptions_on_ended_at", using: :btree
    t.index ["started_at"], name: "index_community_subscriptions_on_started_at", using: :btree
  end

  create_table "document_tags", force: :cascade do |t|
    t.integer  "document_id"
    t.integer  "tag_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["document_id"], name: "index_document_tags_on_document_id", using: :btree
    t.index ["tag_id"], name: "index_document_tags_on_tag_id", using: :btree
  end

  create_table "documents", force: :cascade do |t|
    t.integer  "community_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.index ["community_id", "id"], name: "index_documents_on_community_id_and_id", using: :btree
    t.index ["community_id"], name: "index_documents_on_community_id", using: :btree
    t.index ["user_id"], name: "index_documents_on_user_id", using: :btree
  end

  create_table "downloads", force: :cascade do |t|
    t.integer  "community_id"
    t.integer  "document_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["community_id", "id"], name: "index_downloads_on_community_id_and_id", using: :btree
    t.index ["community_id", "user_id"], name: "index_downloads_on_community_id_and_user_id", using: :btree
    t.index ["community_id"], name: "index_downloads_on_community_id", using: :btree
    t.index ["document_id", "user_id"], name: "index_downloads_on_document_id_and_user_id", using: :btree
    t.index ["document_id"], name: "index_downloads_on_document_id", using: :btree
    t.index ["user_id"], name: "index_downloads_on_user_id", using: :btree
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "community_id"
    t.boolean  "current"
    t.string   "role"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["community_id", "user_id"], name: "index_memberships_on_community_id_and_user_id", using: :btree
    t.index ["community_id"], name: "index_memberships_on_community_id", using: :btree
    t.index ["current"], name: "index_memberships_on_current", using: :btree
    t.index ["user_id"], name: "index_memberships_on_user_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.integer  "community_id"
    t.string   "category"
    t.string   "category_slug"
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["community_id", "id"], name: "index_tags_on_community_id_and_id", using: :btree
    t.index ["community_id", "slug"], name: "index_tags_on_community_id_and_slug", using: :btree
    t.index ["community_id"], name: "index_tags_on_community_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "email"
    t.string   "image"
    t.string   "token"
    t.string   "expires_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["uid"], name: "index_users_on_uid", unique: true, using: :btree
  end

end
