# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_24_055614) do

  create_table "actions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "action_type", null: false
    t.string "action_option"
    t.string "target_type"
    t.integer "target_id"
    t.string "user_type"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action_type", "target_type", "target_id", "user_type", "user_id"], name: "uk_action_target_user", unique: true
    t.index ["target_type", "target_id", "action_type"], name: "index_actions_on_target_type_and_target_id_and_action_type"
    t.index ["user_type", "user_id", "action_type"], name: "index_actions_on_user_type_and_user_id_and_action_type"
  end

  create_table "audit_logs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "action", null: false
    t.integer "record_id", null: false
    t.string "record_type", null: false
    t.text "payload"
    t.text "request"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["action"], name: "index_audit_logs_on_action"
    t.index ["record_type", "record_id"], name: "index_audit_logs_on_record_type_and_record_id"
    t.index ["user_id", "action"], name: "index_audit_logs_on_user_id_and_action"
  end

  create_table "blog_people", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
  end

  create_table "blog_posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "user_id"
    t.integer "likes_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "post_id"
    t.integer "user_id"
    t.string "body"
    t.integer "likes_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.integer "user_id"
    t.integer "likes_count"
    t.integer "stars_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "followers_count"
    t.integer "following_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "star_posts_count"
  end

end
