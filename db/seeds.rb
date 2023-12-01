# db/seeds.rb
require 'faker'

#Crear 500 usuarios con correos electrónicos aleatorios y nombres ficticios
500.times do
  User.create(email: Faker::Internet.email, password: 'password', name: Faker::Name.name, last_name: Faker::Name.last_name)
end

# Asociar eventos a usuarios existentes
users = User.all

# Crear eventos asociados a usuarios
users.each do |user|
  rand(5..20).times do
    user.events.create(
      name: Faker::Lorem.words(number: 3).join(' '),
      description: Faker::Lorem.sentence,
      place: Faker::Address.city,
      date: Date.today + rand(1..30).days,
      start_time: Faker::Time.forward(days: 5, period: :morning),
      end_time: Faker::Time.forward(days: 5, period: :afternoon)
    )
  end
end
