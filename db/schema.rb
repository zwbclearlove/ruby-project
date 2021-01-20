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

ActiveRecord::Schema.define(version: 2021_01_11_070223) do

  create_table "addresses", force: :cascade do |t|
    t.text "address"
    t.string "receiver"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.string "product_name"
    t.integer "product_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "product_id"
    t.integer "user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.datetime "create_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "product_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.datetime "create_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "product_id"
    t.integer "user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.datetime "follow_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "shop_id"
    t.integer "user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.datetime "create_date"
    t.integer "message_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "shop_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.string "product_name"
    t.integer "product_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "order_id"
    t.integer "product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "order_id"
    t.integer "order_status"
    t.float "order_price"
    t.datetime "order_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "shop_id"
    t.integer "user_id"
    t.integer "address_id"
  end

  create_table "product_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.integer "stock"
    t.integer "sales"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "product_type_id"
    t.integer "shop_id"
    t.string "image"
  end

  create_table "sellers", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.text "description"
    t.string "telephone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "seller_id"
    t.string "image"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "nickname"
    t.string "password"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
  end

end
