class Movie < ActiveRecord::Base
	has_many :users, :through => :user_movies
end
