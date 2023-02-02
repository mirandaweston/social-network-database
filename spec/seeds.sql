TRUNCATE TABLE users, posts RESTART IDENTITY; 

-- Below this line there should only be `INSERT` statements.

INSERT INTO users (email_address, username) VALUES ('user_one@gmail.com', 'user_one');
INSERT INTO users (email_address, username) VALUES ('user_two@gmail.com', 'user_two');

-- Below this line there should only be `INSERT` statements.

INSERT INTO posts (title, content, number_of_views, user_id) VALUES ('Yesterday', 'content', 8, 1);
INSERT INTO posts (title, content, number_of_views, user_id) VALUES ('Today', 'more content', 12, 2);
INSERT INTO posts (title, content, number_of_views, user_id) VALUES ('Tomorrow', 'even more content', 20, 1);