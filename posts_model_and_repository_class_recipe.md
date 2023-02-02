# Post Model and Repository Classes Design Recipe


## 1. Designing and creating the Table

Table: posts
id: SERIAL
title: text
content: text
number_of_views: int


## 2. Creating Test SQL seeds

Tests will depend on data stored in PostgreSQL to run.

```sql

-- (file: spec/seeds.sql)

-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE posts RESTART IDENTITY; 

-- Below this line there should only be `INSERT` statements.

INSERT INTO posts (title, content, number_of_views, user_id) VALUES ('Yesterday', 'content', 8, 1);
INSERT INTO posts (title, content, number_of_views, user_id) VALUES ('Today', 'more content', 12, 2);
INSERT INTO posts (title, content, number_of_views, user_id) VALUES ('Tomorrow', 'even more content', 20, 1);

```
## 3. Defining the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby

# Table name: posts

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end
```

## 4. Implementing the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby

# Table name: posts

# Model class
# (in lib/post.rb)

class Post
  attr_accessor :id, :title, :content, :number_of_views, :user_id
end

```


## 5. Defining the Repository Class interface

The Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby

# Repository class
# (in lib/post_repository.rb)

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, number_of_views FROM posts;

    # Returns an array of Post objects.
  end

  #select a single post record
  #given its id in argument (a number)

  def find(id)
  # executes the SQL query
  # SELECT id, title, content, number_of_views FROM posts WHERE id = $1;

  #returns a single Post object
  end

  def create(post)
    # insert a new post
    # post is a new Post object
    # returns nothing
  end

  def delete(id)
  # executes the SQL query
  # DELETE FROM posts WHERE id = $1;

  # returns nothing
  end
end
```

## 6. Test Examples

Ruby code defining the expected behaviour of the Repository class, following the design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby

# 1
# get all posts

repo = PostRepository.new

posts = repo.all

posts.length # => 3

posts.first.id # => 1
posts.first.title # =>  'Yesterday'
posts.first.content # => 'content'
posts.first.number_of_views # => 8
posts.first.user_id # => 1

```

```ruby

# 2
# get a single post

repo = PostRepository.new

post = repo.find(2)

post.title # => 'Today'
post.content # => 'more content'
post.number_of_views # => 12
post.user_id # => 2


```
```ruby

# 3
# insert a new record

repo = PostRepository.new

new_post = Post.new
new_post.title # => 'Makers Academy'
new_post.content # => 'Week 3 is about databases'
new_post.number_of_views # => 5
new_post.user_id # => 2

repo.create(new_post)

all_posts = repo.all

# all_posts should contain the new post

```
```ruby

# 4
# delete a post

repo = PostRepository.new

repo.delete(1)

repo.find(1) # => nil

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby


# file: spec/post_repository_spec.rb

RSpec.describe PostRepository do
  def reset_posts_table
    seed_sq1 = File.read('spec/seeds_posts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_posts_table
  end

  # (tests will go here).
end
```

## 8. Test-driving and implementing the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->



<!-- END GENERATED SECTION DO NOT EDIT -->