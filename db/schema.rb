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

ActiveRecord::Schema.define(version: 20141123214640) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attags", force: true do |t|
    t.integer "post_id"
    t.integer "tagged_user_id"
    t.integer "tagging_user_id"
  end

  add_index "attags", ["post_id"], name: "index_attags_on_post_id", using: :btree
  add_index "attags", ["tagged_user_id"], name: "index_attags_on_tagged_user_id", using: :btree
  add_index "attags", ["tagging_user_id"], name: "index_attags_on_tagging_user_id", using: :btree

  create_table "folders", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hashtags", force: true do |t|
    t.string  "tag"
    t.integer "post_id"
    t.integer "tagging_user_id"
  end

  add_index "hashtags", ["tag"], name: "index_hashtags_on_tag", using: :btree

  create_table "likes", force: true do |t|
    t.integer "post_id", null: false
    t.integer "user_id", null: false
  end

  add_index "likes", ["post_id"], name: "index_likes_on_post_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "posts", force: true do |t|
    t.integer "user_id",   null: false
    t.float   "geo_lat"
    t.float   "geo_long"
    t.string  "caption"
    t.integer "folder_id"
  end

  add_index "posts", ["folder_id"], name: "index_posts_on_folder_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "thumbnails", force: true do |t|
    t.integer "video_id"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",            null: false
    t.string   "email",           null: false
    t.string   "bio"
    t.string   "username"
    t.string   "device_token"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "videos", force: true do |t|
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
    t.integer  "post_id"
  end

  add_index "videos", ["post_id"], name: "index_videos_on_post_id", using: :btree

end
