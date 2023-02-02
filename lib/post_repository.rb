require_relative 'post'
require_relative 'database_connection'

class PostRepository
  def all
    # execute SQL query
    sql = 'SELECT id, title, content, number_of_views, user_id FROM posts;'
    result_set = DatabaseConnection.exec_params(sql, [])

    posts = []

    result_set.each do |record|
      post = Post.new
      post.id = record['id']
      post.title = record['title']
      post.content = record['content']
      post.number_of_views = record['number_of_views']
      post.user_id = record['user_id']

      posts << post
    end

    return posts
  end

  def find(id)
    sql = 'SELECT id, title, content, number_of_views, user_id FROM posts WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]

    post = Post.new
    post.id = record['id']
    post.title = record['title']
    post.content = record['content']
    post.number_of_views = record['number_of_views']
    post.user_id = record['user_id']

    return post
  end

  def create(post)
    sql = 'INSERT INTO posts (title, content, number_of_views, user_id) VALUES ($1, $2, $3, $4);'
    sql_params = [post.title, post.content, post.number_of_views, post.user_id]

    DatabaseConnection.exec_params(sql,sql_params)

    return nil
  end

  def delete(id)
    sql = 'DELETE FROM posts WHERE id = $1;'
    params = [id]

    DatabaseConnection.exec_params(sql,params)

    return nil
  end
end