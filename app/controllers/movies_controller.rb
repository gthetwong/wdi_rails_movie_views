class MoviesController < ApplicationController

  # @@movie_db = [
  #         {"title"=>"The Matrix", "year"=>"1999", "imdbID"=>"tt0133093", "Type"=>"movie"},
  #         {"title"=>"The Matrix Reloaded", "year"=>"2003", "imdbID"=>"tt0234215", "Type"=>"movie"},
  #         {"title"=>"The Matrix Revolutions", "year"=>"2003", "imdbID"=>"tt0242653", "Type"=>"movie"}]

  # route: GET    /movies(.:format)



  def index
    @movies = Movie.all

    respond_to do |format|
      format.html
      format.json { render :json => @@movie_db }
      format.xml { render :xml => @@movie_db.to_xml }
    end
  end

  def search

  end

  def results

  end

  def retresults
  search_str = params[:movie]
  response = Typhoeus.get("www.omdbapi.com", :params => {:s => "#{search_str}"})
  binding.pry
  end

  # route: # GET    /movies/:id(.:format)
  def show
   @movie = get_movie params[:id]
  end

  # route: GET    /movies/new(.:format)
  def new
      
  end

  # route: GET    /movies/:id/edit(.:format)
  def edit
  @movie = get_movie params[:id]
  end

  #route: # POST   /movies(.:format)
  def create
   movie = params.require(:movie).permit(:title,:year)
      new_movie = Movie.create(movie)
      # redirect_to "/movies/#{new_movie.id}"
    redirect_to action: :index
  end

  # route: PATCH  /movies/:id(.:format)
 def update
  movie = get_movie [:id]

  updated_info = params.require(:movie).permit(:title, :year)

  movie.update_attributes(updated_info)

  redirect_to "/movies/#{movie.id}"
  #implement
  #update object in movies_db
  # render :show
  #render shows a page in the same request
  #redirect to will route and act on any methods associated with that request
  
  end

  # route: DELETE /movies/:id(.:format)
 

# route: DELETE /movies/:id(.:format)
  def destroy
      movie = get_movie [:id]
      movie.destroy
      redirect_to "/movies/"
  end
  private
    # id= params[:id]
    #   @plane=Plane.find(id)


  def get_movie movie_id
    # the_movie = @@movie_db.find do |m|
    #   m["imdbID"] == params[:id]
    # end
    id= params[:id]
    the_movie = Movie.find(id)
    if the_movie.nil?
      flash.now[:message] = "Movie not found"
      the_movie = {}
    end
    the_movie
  end

end



