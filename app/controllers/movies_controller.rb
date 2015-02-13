class MoviesController < ApplicationController
  before_action :set_movie, only: [:update, :destroy]

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
    @top_movies = Tmdb::Movie.upcoming
  end

 def search
	@movies = Movie.search(params[:movie_name])
 end

  # GET /movies/1
  # GET /movies/1.json
  def show
  	@movie = Tmdb::Movie.detail(params[:id])
  	@images = Tmdb::Movie.images(params[:id])
  	@cast = Tmdb::Movie.casts(params[:id])
  	@trailers = Tmdb::Movie.trailers(params[:id])
  	@similar_movies = Tmdb::Movie.similar_movies(params[:id])
  end


  def add_to_fav
    if current_user
      #Check if the movie is already in the database
      remote_movie=Tmdb::Movie.detail(params[:movid])
      if remote_movie.poster_path
        @poster = @configuration.base_url+'w154'+remote_movie.poster_path
      else
        @poster = "Notfound"
      end  
      @movie = Movie.where({
        :id => remote_movie.id, 
        :nom => remote_movie.title,
        :affiche => @poster,
        :description => remote_movie.overview 
        }).first_or_create
      # si le lien user et movie inclu le film?  
      if not current_user.movies.include? @movie
        current_user.movies << @movie
      end
      @movies = UsersMovie.where({:movie_id => @movie.id, :user_id => current_user.id})
      @movies.each do |movie|
        if movie.favorit == false || movie.favorit == nil
          movie.favorit = true
          movie.save
          respond_to do |format|
            format.html { redirect_to @movie, notice: 'The movie has been successfully added to your list.' }
            format.json { head :no_content }    
          end  
        end
      end
    end
  end

  def remove_from_fav
    if current_user
      #Check if the movie is already in the database
      @movie = UsersMovie.where({:movie_id =>params[:movid],:user_id => current_user.id})
      @movie.each do |movie|
        if movie.favorit == true
          movie.favorit = false
          movie.save
          if movie.to_see == false and movie.favorit == false and movie.seen == false
            movie.delete
          end  
        end  
      end
      respond_to do |format|
        format.html { redirect_to :back, notice: 'The movie has been successfully removed from your list.' }
        format.json { head :no_content }  
      end
    end
  end

  def add_to
    if current_user
      remote_movie = Tmdb::Movie.detail(params[:movid]) 
      if remote_movie.poster_path
        @poster = @configuration.base_url+'w154'+remote_movie.poster_path
      else
        @poster = "Notfound"
      end  
      @movie = Movie.where({
        :id => remote_movie.id, 
        :nom => remote_movie.title,
        :affiche => @poster,
        :description => remote_movie.overview 
      }).first_or_create  
      if not current_user.movies.include? @movie
        current_user.movies << @movie
      end
      @movies = UsersMovie.where({:movie_id => @movie.id, :user_id => current_user.id}) 
      case params[:action_type]
        when 'favorite'
          @movies.each do |movie|
            if movie.favorit == false || movie.favorit == nil
              movie.favorit = true
              movie.save
            end
          end
        when 'seen'
          @movies.each do |movie|
            if movie.seen == false || movie.seen == nil
              movie.seen = true
              movie.save
            end
          end
        when 'see'
          @movies.each do |movie|
            if movie.to_see == false || movie.to_see == nil
              movie.to_see = true
              movie.save
            end
          end
      end
      respond_to do |format|
              format.html { redirect_to :back, notice: 'The movie has been successfully added to your list.' }
              format.json { head :no_content }    
      end
    end
  end

  def remove_from
    if current_user
      #Check if the movie is already in the database
      @movie = UsersMovie.where({:movie_id =>params[:movid], :user_id => current_user.id})
      case params[:action_type]
      when 'favorite'
        @movie.each do |movie|
        if movie.favorit == true
          movie.favorit = false
          movie.save
          if movie.to_see == false and movie.favorit == false and movie.seen == false
            movie.delete
          end  
        end  
      end
      when 'seen'
        @movie.each do |movie|
          if movie.seen == true
            movie.seen = false
            movie.save
            if movie.to_see == false and movie.favorit == false and movie.seen == false
              movie.delete
            end  
          end  
        end
      when 'see'  
        @movie.each do |movie|
          if movie.to_see == true
            movie.to_see = false
            movie.save
            if movie.to_see == false and movie.favorit == false and movie.seen == false
              movie.delete
            end  
          end  
        end
      end
      respond_to do |format|
        format.html { redirect_to :back, notice: 'The movie has been successfully removed from your list.' }
        format.json { head :no_content }  
      end
    end
  end

  def get_to_fav
    if current_user
      @movies = []
      favorit_movie=UsersMovie.where(:user_id => current_user)
      favorit_movie.each do |movie|
        if movie.favorit == true
           @movies << Movie.find(movie.movie_id)
        end
      end
    end
  end

  def get_to_seen
    if current_user
      @movies = []
      seen_movies=UsersMovie.where(:user_id => current_user)
      seen_movies.each do |movie|
        if movie.seen == true
          @movies << Movie.find(movie.movie_id)
        end
      end
    end
  end

  def get_to_see
    if current_user
      @movies = []
      see_movies=UsersMovie.where(:user_id => current_user)
      see_movies.each do |movie|
        if movie.to_see == true
          @movies << Movie.find(movie.movie_id)
        end
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
      # @movie=Tmdb::Movie.detail(:id)
    end
# 
    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params[:movie]
    end
end
