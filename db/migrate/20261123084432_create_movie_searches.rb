class CreateMovieSearches < ActiveRecord::Migration[8.1]
  def change
    create_table :movie_searches do |t|
      t.string :query

      t.timestamps
    end
    add_index :movie_searches, :query, unique: true
    # unique: true = prevent duplicate search records
  end
end
