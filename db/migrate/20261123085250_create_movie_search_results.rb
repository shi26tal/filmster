class CreateMovieSearchResults < ActiveRecord::Migration[8.1]
  def change
    create_table :movie_search_results do |t|
      t.references :movie_search, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
    add_index :movie_search_results,
          [ :movie_search_id, :movie_id ],
          unique: true
  end
end
