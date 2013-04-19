# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    if Movie.where(["title = ?", movie[:title]]).length == 0
      Movie.create!(movie)
    end
  end
end

Then /the director of "(.*)" should be "(.*)"/ do |title, dir| 
  movie = Movie.find_by_title(title)
  assert movie.director == dir
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  check = /#{e1}.*#{e2}/m
  page.body.should =~ check
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.gsub(/\s+/,"").split(',').each do |rating|
    step = %Q{When I #{uncheck}check "ratings_#{rating}"}
    steps step
  end
end

Then /I should (not )?see movies with ratings: (.*)/ do |notsee, ratings_list|
  ratings = ratings_list.gsub(/\s+/,"").split(',')
  movies = Movie.where(["rating IN (?)", ratings])

  movies.each do |movie|
    step = %Q{Then I should #{notsee}see "#{movie.title}"}
    steps step
  end
end
