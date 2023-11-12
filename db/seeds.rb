# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Rake::Task["csv_load:all"].invoke

@discount1 = BulkDiscount.create!(name: "10 or more", threshold: 10, percentage: 15, merchant_id: 1)
@discount2 = BulkDiscount.create!(name: "15 or more", threshold: 15, percentage: 20, merchant_id: 1)
@discount3 = BulkDiscount.create!(name: "20 or more", threshold: 20, percentage: 25, merchant_id: 1)