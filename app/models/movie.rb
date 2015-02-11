class Movie < ActiveRecord::Base
	has_many :users_movies
	has_many :users, :through => :users_movies

	def self.search(query)
 	@search = Tmdb::Search.new
	@search.resource('movie') # determines type of resource
	@search.query(query) # the query to search against
	@search.fetch # makes request
	end
end
