# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def seed_users
  user_id = 0
  10.times do
    User.create(
      name: "test#{user_id}",
      email: "test#{user_id}@test.com",
      password: '123456',
      password_confirmation: '123456'
    )
    user_id = user_id + 1
  end
end


def seed_categories
  inspiration = ['Karena & Katrina', 'Crafts', 'Challenges', 'Quotes', 'Adventure', 'Workout Gear', 'Reading', 'Other']
  recipes = ['Breakfast', 'Lunch', 'Dinner',
          'Snacking', 'Appetizers', 'Cocktails', 'Meal Prep',
          'Dessert']
  tiugirls = ['Workout Queens', 'Newbie', 'Boss Babes', 'Sunshine Seekers', 'Mamas To Be', 'Mamas']

  inspiration.each do |name|
    Category.create(branch: 'inspiration', name: name)
  end

  recipes.each do |name|
    Category.create(branch: 'recipes', name: name)
  end

  tiugirls.each do |name|
    Category.create(branch: 'tiugirls', name: name)
  end
end

def seed_posts
  categories = Category.all

  categories.each do |category|
    5.times do
      Post.create(
        title: Faker::Lorem.sentences[0],
        content: Faker::Lorem.sentences[0],
        user_id: rand(1..9),
        category_id: category.id
      )
    end
  end
end

seed_users
seed_categories
seed_posts
