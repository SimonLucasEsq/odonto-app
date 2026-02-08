# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_02_08_021943) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "articles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.decimal "price"
    t.datetime "updated_at", null: false
  end

  create_table "work_order_items", force: :cascade do |t|
    t.bigint "article_id", null: false
    t.datetime "created_at", null: false
    t.integer "quantity"
    t.datetime "updated_at", null: false
    t.bigint "work_order_id", null: false
    t.index ["article_id"], name: "index_work_order_items_on_article_id"
    t.index ["work_order_id"], name: "index_work_order_items_on_work_order_id"
  end

  create_table "work_orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "status"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "work_order_items", "articles"
  add_foreign_key "work_order_items", "work_orders"
end
