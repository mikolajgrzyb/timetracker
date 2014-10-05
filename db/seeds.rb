# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Account.delete_all
Member.delete_all

user1 = User.create! email: 'demo@timetracker.com', password: 'password', first_name: 'demo', last_name: 'demo'
user1.accounts.create! company_name: 'demo company'
