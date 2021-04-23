require "rails_helper"

# https://gist.github.com/lkrych/cd51aa955779f87671468aa0eb8c8863
RSpec.describe MoviesController, type: :controller do

    describe "index page" do
        it "shows the index view" do
            get :index
            expect(response).to render_template("index")
        end
    end
    
    describe "show page" do
        it "shows the show view" do
            movie1 = Movie.create!(title: "Alien", director: "Ridley Scott")
            get :show, :id => movie1
            expect(assigns(:movie)).to eq(movie1)
        end
    end
    
    describe "new page" do
        it "shows the new view" do
            get :new
            expect(response).to render_template("new")
        end
    end
    
    describe "new movie" do
        it "add a new movie" do
            new_movie = {title: "Alien", director: "Ridley Scott"}
            expect {post :create, movie: new_movie}.to change(Movie, :count).by(1)
        end
    end

    describe "edit page" do
        it "shows the edit view" do
            movie1 = Movie.create!(title: "Alien", director: "Ridley Scott")
            get :edit, {:id => movie1.to_param}
            expect(assigns(:movie)).to eq(movie1)
        end
    end
    
    describe "update movie" do
        it "updates a movies details" do
            movie1 = Movie.create!(title: "Alien", director: "Ridley Scott")
            put :update, {:id => movie1.id, :movie => {:title => "New title"}}
            movie1.reload
            expect(movie1.title).to eq("New title")
        end
    end

    describe "delete movie" do        
        it "deletes a movie" do
            movie1 = Movie.create!(title: "Alien", director: "Ridley Scott")
            expect{delete :destroy, :id => movie1.id}.to change(Movie, :count).by(-1)
        end
    end
    
    describe "search by director" do
        it "find movies by the same director" do
            movie1 = Movie.create!(title: "Alien", director: "Ridley Scott")
            movie2 = Movie.create!(title: "Aliens", director: "James Cameroon")
            movie3 = Movie.create!(title: "Prometheus", director: "Ridley Scott")
            get :same_director, {:id => movie1.to_param}
            expect(assigns(:movies)).to include(movie1)
            expect(assigns(:movies)).to include(movie3)
            expect(assigns(:movies)).not_to include(movie2)
        end
        
        
        it "find movies with no director" do
            movie1 = Movie.create!(title: "Alien", director: "Ridley Scott")
            movie2 = Movie.create!(title: "Aliens", director: "James Cameroon")
            movie3 = Movie.create!(title: "Prometheus", director: "Ridley Scott")
            get :same_director, {:id => movie2.to_param}
            expect(flash[:notice]).to eq("Movie 'Aliens' has no director info.")
            expect(response).to redirect_to(movies_path)
        end 
    end

end
