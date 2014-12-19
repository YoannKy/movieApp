class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   require 'themoviedb'
  protect_from_forgery with: :exception
	  
	  before_action :authenticate_user!	
	  before_filter :set_config
  	Tmdb::Api.key("901fa4892abc734e3c5c663106aecd30")
  def set_config
  	@configuration=Tmdb::Configuration.new
  end
end
