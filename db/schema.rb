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

ActiveRecord::Schema[7.0].define(version: 2025_04_07_210119) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.bigint "transaction_id", null: false
    t.string "action_type", null: false
    t.jsonb "args", default: {}
    t.index ["transaction_id", "action_type"], name: "index_actions_on_transaction_id_and_action_type"
    t.index ["transaction_id"], name: "index_actions_on_transaction_id"
  end

  create_table "blocks", force: :cascade do |t|
    t.integer "height", null: false
    t.text "block_hash", null: false
    t.datetime "created_at", null: false
    t.index ["block_hash"], name: "index_blocks_on_block_hash", unique: true
    t.index ["height"], name: "index_blocks_on_height", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.text "hash", null: false
    t.text "sender", null: false
    t.text "receiver", null: false
    t.bigint "block_id", null: false
    t.datetime "created_at", null: false
    t.index ["block_id"], name: "index_transactions_on_block_id"
    t.index ["hash"], name: "index_transactions_on_hash", unique: true
  end

  add_foreign_key "actions", "transactions"
  add_foreign_key "transactions", "blocks"
end
