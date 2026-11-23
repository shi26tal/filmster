class CreateMovies < ActiveRecord::Migration[8.1]
  def change
    create_table :movies do |t|
      t.integer :tmdb_id
      t.string :title
      t.text :overview
      t.string :poster_path
      t.date :release_date
      t.float :popularity
      t.integer :runtime
      t.bigint :budget
      t.bigint :revenue
      t.string :tagline
      t.boolean :tmdb_details_fetched, default: false

      t.timestamps
    end

    add_index :movies, :tmdb_id, unique: true
  end
end
