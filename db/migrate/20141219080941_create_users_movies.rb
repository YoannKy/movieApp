class CreateUsersMovies < ActiveRecord::Migration
  def change
    create_table :users_movies do |t|
    	t.belongs_to :users
    	t.belongs_to :movies
    	t.boolean :seen
    	t.timestamps
    end
  end
end