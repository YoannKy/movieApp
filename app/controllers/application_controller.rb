class ApplicationController < ActionController::Base
 	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
 	protect_from_forgery with: :exception  
	before_action :authenticate_user!	
	before_filter :set_config, :set_list
  def set_config
  	@configuration=Tmdb::Configuration.new
  end

  def set_list
  	if current_user
  		@favorit=[]
  		@seen=[]
      @to_see=[]
  		moviesCheck=UsersMovie.where(:user_id => current_user)
  		moviesCheck.each do |movie|
  			if movie.favorit == true
  				@favorit << movie.movie_id
  			end 	
  			if movie.seen == true
  				@seen << movie.movie_id
  			end
        if movie.to_see == true
          @to_see << movie.movie_id
        end
  		end
	end
  end
end
