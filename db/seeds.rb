# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'factory_girl_rails'

User.create(email: "admin@info.com", password: 'password', admin: true)
User.create(email: "dennis.joonsuk.yi@gmail.com", password: '1', firstname: "Dennis", lastname: "Yi")



FactoryGirl.define do
  factory :user do
    firstname { Faker::Name.first_name }
    lastname  { Faker::Name.last_name }
    email     { Faker::Internet.safe_email }
    password '1'
    password_confirmation '1'
  end

end

20.times do
  u = FactoryGirl::build(:user)
  u.save
end