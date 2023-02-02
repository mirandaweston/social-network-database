require 'user_repository'
require 'user'

RSpec.describe UserRepository do
  DatabaseConnection.connect('social_network_test')
  def reset_users_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_users_table
  end

  it "tests the '#all' method with psql" do
    
    repo = UserRepository.new

    users = repo.all

    expect(users.length).to eq 2
    expect(users.first.id.to_i).to eq 1
    expect(users.first.email_address).to eq 'user_one@gmail.com'
    expect(users.first.username).to eq 'user_one'
  end

  it "returns a single user" do
    repo = UserRepository.new

    user = repo.find(1)

    expect(user.id.to_i).to eq 1
    expect(user.email_address).to eq 'user_one@gmail.com'
    expect(user.username).to eq 'user_one'
  end

  it "creates a new user" do
    repo = UserRepository.new

    new_user = double :user, email_address:'user_three@gmail.com', username:'user_three'

    repo.create(new_user)

    all_users = repo.all

    expect(all_users.length).to eq 3
    expect(all_users.last.email_address).to eq 'user_three@gmail.com'
    expect(all_users.last.username).to eq 'user_three'
  end

  it "deletes a user from the database" do
    repo = UserRepository.new

    repo.delete(1)

    all_users = repo.all

    expect(all_users.length).to eq 1
  end
end