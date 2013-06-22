require 'spec_helper'

describe MoviesController do


  describe 'searching TMDb' do
    it 'should call the model method that performs TMDb search' do
      Movie.should_receive(:find_in_tmdb).with('hardware')
      post :search_tmdb, {:search_terms => 'hardware'}
    end
    it 'should select the Search Results template for rendering' do
      Movie.stub(:find_in_tmdb)
      post :search_tmdb, {:search_terms => 'hardware'}
      response.should render_template('search_tmdb')
    end
    it 'should make the TMDb search results available to that template' do
      fake_results = [mock('Movie'), mock('Movie')]
      Movie.stub(:find_in_tmdb).and_return(fake_results)
      post :search_tmdb, {:search_terms => 'hardware'}
      # look for controller method to assign @movies
      assigns(:movies).should == fake_results
    end
  end
end
