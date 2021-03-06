class ReviewsController < ApplicationController
    before_action :require_signin
    before_action :set_movie

    def index
        @reviews = @movie.reviews
    end
    
    def new 
        @reviews = @movie.reviews.new
    end

    
        @reviews = @movie.reviews.new(review_params)
        @review.user = current_user
        if @reviews.save
            redirect_to movie_reviews_path(@movie),
                            notice: "Thanks for your review!"
        else
            render :new
        end
    end

    def set_movie
        @movie = Movie.find(params[:movie_id])
    end

private
    def review_params
        params.require(:review)
            .permit( :stars, :comment)
    end
end


