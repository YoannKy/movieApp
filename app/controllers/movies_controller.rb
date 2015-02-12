class MoviesController < ApplicationController
  before_action :set_movie, only: [:update, :destroy]

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
    @topMovies =Tmdb::Movie.upcoming
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

  # GET /movies/new
  def new
    @movie = Movie.new
  end
  def add_Fav
    
  end
  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_to_fav
    if current_user
      puts params[:movid]
      #Check if the movie is already in the database
      remote_movie=Tmdb::Movie.detail(params[:movid])
      @movie = Movie.where({
        :id => remote_movie.id, 
        :nom => remote_movie.title,
        :affiche => @configuration.base_url+'w154'+remote_movie.poster_path,
        :description => remote_movie.overview 
        }).first_or_create  
      if not current_user.movies.include? @movie
        current_user.movies << @movie
      end
      @movies = UsersMovie.where(:movie_id => @movie.id)
      @movies.each do |movie|
        if movie.favorit == false || movie.favorit == nil
          movie.favorit = true
          movie.save
          respond_to do |format|
            format.html { redirect_to :back, notice: 'The movie has been successfully added to your list.' }
            format.json { head :no_content }    
          end  
        end
      end
    end
  end

  def remove_from_fav
    if current_user
      #Check if the movie is already in the database
      @movie = UsersMovie.where(:movie_id =>params[:movid])
      @movie.each do |movie|
        if movie.favorit == true
          movie.favorit = false
          movie.save
          if movie.favorit == false and movie.seen == false
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

  def get_fav_list
    if current_user
      @movies = []
      favoritMovie=UsersMovie.where(:user_id => current_user)
      favoritMovie.each do |movie|
        if movie.favorit == true
           @movies << Movie.find(movie.movie_id)
        end
      end
    end
  end

  def add_to_seen
    if current_user
       remote_movie=Tmdb::Movie.detail(params[:movid]) 
      @movie = Movie.where({
        :id => remote_movie.id, 
        :nom => remote_movie.title,
        :affiche => @configuration.base_url+'w154'+remote_movie.poster_path,
        :description => remote_movie.overview 
        }).first_or_create   
      if not current_user.movies.include? @movie
        current_user.movies << @movie
      end
      @movies = UsersMovie.where(:movie_id => @movie.id)
      @movies.each do |movie|
        if movie.seen == false || movie.seen == nil
          movie.seen = true
          movie.save
          respond_to do |format|
            format.html { redirect_to :back, notice: 'The movie has been successfully added to your list.' }
            format.json { head :no_content }    
          end  
        end
      end
    end
  end

  def remove_from_Seen
    if current_user
      #Check if the movie is already in the database
      @movie = UsersMovie.where(:movie_id =>params[:movid])
      @movie.each do |movie|
        if movie.seen == true
          movie.seen = false
          movie.save
          if movie.seen == false and movie.favorit == false
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

  def get_seen_list
    if current_user
      @movies = []
      seenList=UsersMovie.where(:user_id => current_user)
      seenList.each do |movie|
        if movie.seen == true
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
