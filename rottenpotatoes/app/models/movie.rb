class Movie < ActiveRecord::Base
  
  def self.get_same_director(id)
    director = Movie.find(id).director
    
#     if (director.nil? || director.empty?)
#       return ""
#     elsif
      return Movie.where(director: director)
#     end
  end
  
end
