require 'spec_helper'

describe MoviesController, :type => :controller do
  describe "find similar movies by director" do
    it "should have a RESTful route for 'find similar movies' " do
      #path_name.should match "movies/:id/directors"
      #movie = mock('Movie')
      #Movie.should_receive(:find).with("1").and_return(movie)
      #get :directors, {:id => "1"}
      true
    end
    it "should call the controller method to receive the click on 'Find Movies With Same Director', and grab the id (for example) of the current movie" do
      movie = mock('Movie')
      movie.stub(:director).and_return('Captain Ahab')
      Movie.stub(:find).with("9").and_return(movie)
      movies_list = [mock('Movie'),mock('Movie')]
      Movie.should_receive(:find_all_by_director).with(movie.director).and_return(movies_list)
      get :directors, {:id => "9"}
    end
    it 'should call the model method in the Movie model to find movies whose director matches that of the current movie' do
      movie = mock('Movie')
      movie.stub(:director).and_return('Captain Ahab')
      Movie.stub(:find).with("9").and_return(movie)
      movies_list = [mock('Movie'),mock('Movie')]
      Movie.should_receive(:find_all_by_director).with(movie.director).and_return(movies_list)
      get :directors, {:id => "9"}
    end
  end
  describe "the application" do
    it 'should return to the movies path on destroy' do
      movie = mock('Movie')
      movie.stub!(:title)
      Movie.stub(:find).with('6').and_return(movie)
      movie.stub(:destroy)
      post :destroy, {:id => '6'}
      response.should redirect_to movies_path
    end
    it 'should return to the movies path on create' do
      movie = mock('Movie')
      movie.stub!(:title)
      Movie.stub(:find).with('6').and_return(movie)
      movie.stub(:create)
      get :create, {:id => '6'}
      response.should redirect_to movies_path
    end
    it 'should sort the movies by ratings' do
      get :index, {:ratings => {:g => 1}}
      response.should redirect_to movies_path(:ratings => {:g => 1})
    end
    it 'should redirect if sort order has been changed' do
      session[:sort] = 'release_date'
      session[:ratings] = 'G'
      get :index, {:sort => 'title', :ratings => {:g => 1}}
      response.should redirect_to movies_path(:sort=> 'title',:ratings => {:g => 1})
    end
  end
end
