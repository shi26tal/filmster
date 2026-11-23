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

ActiveRecord::Schema[8.1].define(version: 2026_11_23_085250) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "movie_search_results", force: :cascade do |t|
    t.bigint "movie_search_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_movie_search_results_on_movie_id"
    t.index ["movie_search_id", "movie_id"], name: "index_movie_search_results_on_movie_search_id_and_movie_id", unique: true
    t.index ["movie_search_id"], name: "index_movie_search_results_on_movie_search_id"
  end

  create_table "movie_searches", force: :cascade do |t|
    t.string "query"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["query"], name: "index_movie_searches_on_query", unique: true
  end

  create_table "movies", force: :cascade do |t|
    t.integer "tmdb_id"
    t.string "title"
    t.text "overview"
    t.string "poster_path"
    t.date "release_date"
    t.float "popularity"
    t.integer "runtime"
    t.bigint "budget"
    t.bigint "revenue"
    t.string "tagline"
    t.boolean "tmdb_details_fetched", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tmdb_id"], name: "index_movies_on_tmdb_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "movie_search_results", "movie_searches"
  add_foreign_key "movie_search_results", "movies"
end
