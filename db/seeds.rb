# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

john = User.find_or_create_by!(
  email: "john.doe@example.com"
  ) do |user|
  user.password = "password"
end

User.find_or_create_by!(
  email: "jane.doe@example.com"
  ) do |user|
  user.password = "password"
end

topics = [
  { "title": "Product tester.", "x_link": "https://twitter.com/CatWorkers/status/1747996062000796060", "hashtag": "bedtester" },
  { "title": "Asus hacker", "x_link": "https://twitter.com/CatWorkers/status/1747065669487624601", "hashtag": "hacker" },
  { "title": "Biscuits chef", "x_link": "https://twitter.com/CatWorkers/status/1746950191905738842", "hashtag": "biscuitschef" },
]

topics.each do |topic|
  Topic.find_or_create_by!(title: topic[:title], x_link: topic[:x_link] , hashtag: topic[:hashtag], user: john)
end
