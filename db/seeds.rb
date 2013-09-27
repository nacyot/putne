# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


def create_user
  puts 'CREATING ROLES'
  Role.create({:name => 'admin'})
  Role.create({ :name => 'user' })
  puts 'SETTING UP DEFAULT USER LOGIN'

  admin = User.new
  admin.email = "admin@example.com"
  admin.password = "abcd1234"
  admin.password_confirmation = "abcd1234"
  admin.save!

  puts 'New user created: ' << admin.email
  user = User.new
  user.email = "user@example.com"
  user.password = "abcd1234"
  user.password_confirmation = "abcd1234"
  user.save!

  puts 'New user created: ' << user.email
  admin.add_role :admin
end

def create_category
  ScoreCategory.create(name: "COMPLEXITY")
  ScoreCategory.create(name: "LOC")
  ScoreCategory.create(name: "CHURN")

  ScoreSource.create(name: "FLOG")
  ScoreSource.create(name: "SAIKURO")
  ScoreSource.create(name: "FILE_CHURN")
  ScoreSource.create(name: "CLASS_CHURN")
  ScoreSource.create(name: "METHOD_CHURN")

  SmellCategory.create(name: "SMELL")

  SmellSource.create(name: "ROODI")
  SmellSource.create(name: "REEK")
end

create_user
create_category
