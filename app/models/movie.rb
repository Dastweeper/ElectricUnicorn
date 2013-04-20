class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  def self.match_director (movie_id)
    movie = self.find(movie_id)
    movies = self.where("director = ? AND title != ?",movie[:director],movie[:title])
    return movies
  end
end
