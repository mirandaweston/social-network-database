require 'post_repository'
require 'post'

RSpec.describe PostRepository do
  DatabaseConnection.connect('social_network_test')
  def reset_posts_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_posts_table
  end

  it "tests the '#all' method with psql" do
    repo = PostRepository.new

    posts = repo.all

    expect(posts.length).to eq 3
    expect(posts.first.id.to_i).to eq 1
    expect(posts.first.title).to eq 'Yesterday'
    expect(posts.first.content).to eq 'content'
    expect(posts.first.number_of_views.to_i).to eq 8
    expect(posts.first.user_id.to_i).to eq 1
  end

  it "returns a single post" do
    repo = PostRepository.new

    post = repo.find(1)

    expect(post.id.to_i).to eq 1
    expect(post.title).to eq 'Yesterday'
    expect(post.content).to eq 'content'
    expect(post.number_of_views.to_i).to eq 8
    expect(post.user_id.to_i).to eq 1
  end

  it "creates a new post" do
    
    repo = PostRepository.new

    new_post = Post.new
    new_post.title = 'Makers Academy'
    new_post.content = 'Week 3 is about databases'
    new_post.number_of_views = 5
    new_post.user_id = 2

    repo.create(new_post)

    all_posts = repo.all

    expect(all_posts.length).to eq 4
    expect(all_posts.last.title).to eq 'Makers Academy'
    expect(all_posts.last.content).to eq 'Week 3 is about databases'
    expect(all_posts.last.number_of_views.to_i).to eq 5
    expect(all_posts.last.user_id.to_i).to eq 2
  end

  it "deletes a post from the database" do
    repo = PostRepository.new

    repo.delete(1)

    all_posts = repo.all

    expect(all_posts.length).to eq 2
  end
end