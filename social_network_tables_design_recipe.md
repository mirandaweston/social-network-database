# Two Tables Design Recipe Template



## 1. Extract nouns from the user stories or specification

```

As a social network user,
So I can have my information registered,
I'd like to have a user account with my email address.

As a social network user,
So I can have my information registered,
I'd like to have a user account with my username.

As a social network user,
So I can write on my timeline,
I'd like to create posts associated with my user account.

As a social network user,
So I can write on my timeline,
I'd like each of my posts to have a title and a content.

As a social network user,
So I can know who reads my posts,
I'd like each of my posts to have a number of views.

```

```
Nouns:

user account, email address, username, posts, title, content, number of views
```

## 2. Infer the Table Name and Columns


| Record                | Properties                     |
| --------------------- | ------------------------------ |
| users                 | email address, username
| posts                 | title, content, number of views

1. Name of the first table (always plural): `users` 

    Column names: `email_address`, `username`

2. Name of the second table (always plural): `posts` 

    Column names: `title`, `content`, `number_of_views`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).


```

Table: users
id: SERIAL
email_address: text
username: text

Table: posts
id: SERIAL
title: text
content: text
number_of_views: int
```

## 4. Decide on The Tables Relationship


To decide on which one:

1. Can one [TABLE ONE] have many [TABLE TWO]? (Yes/No)
2. Can one [TABLE TWO] have many [TABLE ONE]? (Yes/No)

You'll then be able to say that:

1. **[A] has many [B]**
2. And on the other side, **[B] belongs to [A]**
3. In that case, the foreign key is in the table [B]

```

1. Can one user have many posts? YES
2. Can one post have many users? NO

-> Therefore,
Post -> many to one -> User

The foreign key is on the posts table.

```

## 4. Write the SQL.

```sql

-- file: social_network_table.sql

-- Create the table without the foreign key first.
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email_address text,
  username text,
);

-- Then the table with the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text
  number_of_views int
-- The foreign key name is always {other_table_singular}_id
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 social_network < social_network_table.sql
```

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---


<!-- END GENERATED SECTION DO NOT EDIT -->