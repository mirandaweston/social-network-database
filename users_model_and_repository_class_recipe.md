# Users Model and Repository Classes Design Recipe


## 1. Designing and creating the Table

Table: users
id: SERIAL
email_address: text
username: text


## 2. Creating Test SQL seeds

Tests will depend on data stored in PostgreSQL to run.

```sql

-- (file: spec/seeds.sql)

-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE users RESTART IDENTITY; 

-- Below this line there should only be `INSERT` statements.

INSERT INTO users (email_address, username) VALUES ('user_one@gmail.com', 'user_one');
INSERT INTO users (email_address, username) VALUES ('user_two@gmail.com', 'user_two');

```
## 3. Defining the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby

# Table name: users

# Model class
# (in lib/user.rb)
class User
end

# Repository class
# (in lib/user_repository.rb)
class UserRepository
end
```

## 4. Implementing the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby

# Table name: users

# Model class
# (in lib/user.rb)

class User
  attr_accessor :id, :email_address, :username
end

```


## 5. Defining the Repository Class interface

The Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby

# Repository class
# (in lib/user_repository.rb)

class UserRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, email_address, username FROM users;

    # Returns an array of User objects.
  end

  #select a single user record
  #given its id in argument (a number)

  def find(id)
  #executes the SQL
  #SELECT id, email_address, username FROM users WHERE id = $1;

  #returns a single User object
  end

  def create(user)
    # insert a new user
    # user is a new User object
    # returns nothing
  end

  def delete(id)
  # executes the SQL query
  # DELETE FROM users WHERE id = $1;

  # returns nothing
  end
end
```

## 6. Test Examples

Ruby code defining the expected behaviour of the Repository class, following the design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby

# 1
# get all users

repo = UserRepository.new

users = repo.all

users.length # => 3

users.first.id # =>  1
users.first.email_address # =>  'user_one@gmail.com'
users.first.username # => 'user_one'

```

```ruby

# 2
# get a single user

repo = UserRepository.new

user = repo.find(2)

user.email_address # => 'user_two@gmail.com'
user.username # => 'user_two'

```
```ruby


```
```ruby

# 4
# create a new record

repo = UserRepository.new

new_user = double :user, email_address:'user_three@gmail.com', username:'user_three'

repo.create(new_user)

all_users = repo.all

all_users.length # => 3
all_users.last.email_address # => 'user_three@gmail.com'
all_users.last.username # => 'user_three'

# all_users should contain the new user

```
```ruby

# 5
# delete a user

repo = UserRepository.new

repo.delete(1)

repo.find(1) # => nil

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby


# file: spec/user_repository_spec.rb

  def reset_users_table
    seed_sq1 = File.read('spec/seeds_users.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_users_table
  end

  # (tests will go here).
```

## 8. Test-driving and implementing the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->



<!-- END GENERATED SECTION DO NOT EDIT -->