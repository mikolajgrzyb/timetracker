namespace :create do
  desc 'Creates sample data'
  task :sample => :environment do
    User.destroy_all
    Account.destroy_all
    4.times do |i|
      User.create! first_name: "test#{i}", last_name: 'tescior', email: "test#{i}@test.pl", password: 'test1234', password_confirmation: 'test1234', tos_accepted: true
    end
    account = Account.create! company_name: 'test company'

    User.all.each_with_index do |user, i|
      Member.create! account: account, user: user, role: i == 0 ? 'owner' : 'regular'
    end
  end
end
