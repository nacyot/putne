# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts 'CREATING ROLES'
Role.create([
             { :name => 'admin' }, 
             { :name => 'user' }, 
            ], :without_protection => true)

puts 'SETTING UP DEFAULT USER LOGIN'

admin = User.new
admin.email = "admin@example.com"
admin.password = "adcd1234"
admin.password_confirmation = "abcd1234"
admin.save

puts 'New user created: ' << admin.email

user = User.new
user.email = "user@example.com"
user.password = "adcd1234"
user.password_confirmation = "abcd1234"
user.save

puts 'New user created: ' << user.email
admin.add_role :admin
