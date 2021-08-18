# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Recipe.destroy_all
Product.destroy_all
Ingredient.destroy_all
Category.destroy_all
categories = ['Fruits', 'Vegetables', 'Meat & Fish', 'Dairy', 'Spices', 'Frozen', 'Pantry', 'Other']
menus = ['Traditional', 'Vegetarian', 'Easy', 'Light', 'Budget Friendly', 'Kids Friendly']

categories.each do |cat|
  Category.create(name: cat)
end

menus.each do |menu|
  number = rand(2..6)
  Menu.create(
    title: menu,
    members: number,
    category: menu
  )
end

@categories = Category.all.to_a
160.times do
  @categories.shuffle!
  categ_id = @categories.sample.id
  random = rand(1..3)
  name = case random
         when 1 then Faker::Food.unique.ingredient
         when 2 then Faker::Food.unique.fruits
         when 3 then Faker::Food.unique.vegetables
         end
  Product.create(
    name: name,
    category_id: categ_id
  ) unless Product.select(:name).map(&:name).include?(name)
end

50.times do
  number = rand(1..10)
  Recipe.create(
    name: Faker::Food.unique.dish,
    description: Faker::Food.description,
    steps: Faker::Lorem.paragraph(sentence_count: 10),
    picture: Faker::LoremPixel.image(category: 'food', number: number)
  )
end

Menu.all.each do |m|
  @recipes = Recipe.all.to_a
  @recipes.shuffle!
  ingred_qty = rand(4..10)
  ingred_qty.times do
    recip_id = @recipes.pop.id
    RecipeMenu.create(
      menu_id: m.id,
      recipe_id: recip_id
    )
  end
end

Recipe.all.each do |r|
  @products = Product.all.to_a
  @products.shuffle!
  ingred_qty = rand(4..8)
  ingred_qty.times do 
    prod_id = @products.pop.id
    amount = rand(10.0..160.0).to_f / 40
    Ingredient.create(
      recipe_id: r.id,
      product_id: prod_id,
      amount: amount.round(2),
      measure: Faker::Measurement.volume(amount: 'none')
    )
  end
end
AdminUser.create!(email: 'admin@example.com', password: '123456', password_confirmation: '123456', role: 'admin') if Rails.env.development?
AdminUser.create!(email: 'nutricionist@example.com', password: '123456', password_confirmation: '123456') if Rails.env.development?
User.create!(name: 'Joaquin', lastname: 'Sepulveda', email: 'test@example.com', password: '123456', password_confirmation: '123456', profile_picture: "https://desafiosdev.s3.amazonaws.com/uploads/user2/photo/7746/IMG_3254_Facetune_06-03-2020-10-42-30.jpg", role: 'admin' ) if Rails.env.development?