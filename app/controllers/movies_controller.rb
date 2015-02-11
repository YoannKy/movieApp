class MoviesController < ApplicationController
  before_action :set_movie, only: [:update, :destroy]

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
    @topMovies =Tmdb::Movie.upcoming
  end

 def search
	@movies = Movie.search(params[:q])
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

  def addToFav
    if current_user
      @movie = Movie.where({id:params[:id]}).first_or_create  
      current_user.movies << @movie
      current_user.save 
      redirect_to :back 
    end
  end

  def getFavList
    if current_user
      @movies = []
      current_user.movies.each do |movie|
        @movies << Tmdb::Movie.detail(movie.id)
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
