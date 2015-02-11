class CreateUsersMovies < ActiveRecord::Migration
  def change
    create_table :users_movies do |t|
    	t.integer :user_id
    	t.integer :movie_id
    	t.boolean :seen
    	t.boolean :favorit
    	t.timestamps
    end
  end
end	
