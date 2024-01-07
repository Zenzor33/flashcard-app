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

ActiveRecord::Schema[7.0].define(version: 2024_01_07_130700) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deck_flashcards", force: :cascade do |t|
    t.bigint "deck_id", null: false
    t.bigint "flashcard_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "correct_count", default: 0, null: false
    t.integer "incorrect_count", default: 0, null: false
    t.float "accuracy", default: 0.0, null: false
    t.string "category", default: "new", null: false
    t.integer "attempts", default: 0, null: false
    t.index ["deck_id", "flashcard_id"], name: "index_deck_flashcards_on_deck_id_and_flashcard_id", unique: true
    t.index ["deck_id"], name: "index_deck_flashcards_on_deck_id"
    t.index ["flashcard_id"], name: "index_deck_flashcards_on_flashcard_id"
  end

  create_table "decks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "total_correct_count", default: 0, null: false
    t.integer "total_incorrect_count", default: 0, null: false
    t.integer "total_attempts", default: 0, null: false
    t.float "average_accuracy", default: 0.0, null: false
    t.index ["user_id"], name: "index_decks_on_user_id"
  end

  create_table "dummies", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.datetime "born_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.index ["email"], name: "index_dummies_on_email", unique: true
  end

  create_table "flashcards", force: :cascade do |t|
    t.string "front", null: false
    t.string "back", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "deck_flashcards", "decks"
  add_foreign_key "deck_flashcards", "flashcards"
  add_foreign_key "decks", "users"
end
