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

70.times do
  random = rand(1..3)
  name = case random
         when 1 then Faker::Food.unique.ingredient
         when 2 then Faker::Food.unique.fruits
         when 3 then Faker::Food.unique.vegetables
         end
  Product.create(
    name: name
  )
end

40.times do
  number = rand(1..10)
  Recipe.create(
    name: Faker::Food.unique.dish,
    description: Faker::Food.description,
    steps: Faker::Lorem.paragraph(sentence_count: 10),
    picture: Faker::LoremPixel.image(category: 'food', number: number)
  )
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
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', role: 'admin') if Rails.env.development?
AdminUser.create!(email: 'nutricionist@example.com', password: '123456', password_confirmation: '123456') if Rails.env.development?