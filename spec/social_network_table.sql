CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email_address text,
  username text
);


CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  number_of_views int,
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);