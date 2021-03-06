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

ActiveRecord::Schema.define(version: 20171014142614) do

  create_table "events", force: :cascade do |t|
    t.text "title", null: false
    t.text "category", null: false
    t.text "location"
    t.text "description_short"
    t.text "description"
    t.text "url"
    t.text "reg_url"
    t.text "image_url"
    t.text "video_url"
    t.datetime "date_start"
    t.datetime "date_end"
    t.decimal "latitude"
    t.decimal "longitude"
    t.integer "zoom"
    t.text "email"
    t.text "facebook"
    t.text "vk"
    t.text "twitter"
    t.text "pinterest"
    t.text "linkedin"
    t.text "odnoklasniki"
    t.text "googleplus"
    t.text "instagram"
    t.text "tumblr"
    t.text "youtube"
    t.boolean "hasReg", default: false, null: false
    t.boolean "hasParty", default: false, null: false
    t.boolean "hasMaps", default: false, null: false
    t.boolean "hasSponsors", default: false, null: false
    t.boolean "hasPartner", default: false, null: false
    t.boolean "hasPress", default: false, null: false
    t.boolean "hasTimeTable", default: false, null: false
    t.boolean "hasSpeakers", default: false, null: false
    t.boolean "hasProducts", default: false, null: false
    t.boolean "hasIndustryNews", default: false, null: false
  end

  create_table "news_posts", force: :cascade do |t|
    t.text "title", null: false
    t.text "category", null: false
    t.text "rubric"
    t.text "event_name"
    t.text "image_url"
    t.text "web_url"
    t.datetime "date", null: false
    t.text "description"
  end

  create_table "schedule_records", force: :cascade do |t|
    t.integer "event_id"
    t.text "title", null: false
    t.text "place"
    t.datetime "time_start"
    t.integer "duration"
    t.text "description"
    t.index ["event_id"], name: "index_schedule_records_on_event_id"
  end

end
