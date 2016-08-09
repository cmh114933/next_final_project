# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

PricingPlan.create(price_of_coin:1, value_of_coin:1000)
PricingPlan.create(price_of_coin:4, value_of_coin:5000)
PricingPlan.create(price_of_coin:10, value_of_coin:12000)
PricingPlan.create(price_of_coin:15, value_of_coin:18000)