class MoviesController < ApplicationController

  before_action :require_signin, excpet: [:index, :show]
  before_action :require_signin, excpet: [:index, :show]


  def index
    @movies = Movie.released
  end

  def show
    @movie = Movie.find(params[:id])
    @fans = @movie.fans

    if current_user
      @favorite_movies = current_user.favorites.find_by(movie_id: @movie.id)
    end

    @genres = @movie.genres
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update()
      redirect_to @movie, notice:  "Movie successfully updated!"
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end

  
    @movie = Movie.new()
    if @movie.save
      redirect_to @movie, notice: "Movie successfully created!"
    else
      render :new
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_url, alert: "Movie successfully deleted!"
  end

  def require_admin
    unless current_user_admin?
      redirect_to root_url, alert: "Unauthorized access!"
    end
  end

  def current_user_admin?
    current_user && current_user?
  end

  helper_method :current_user_admin?
private

  def movie_params
    params.require(:movie)
      .permit(:title, :description, :rating, :released_on, :total_gross, :cast, :director, :duration, :image_file_name)
  end
end
