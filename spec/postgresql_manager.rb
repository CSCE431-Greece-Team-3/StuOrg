require "pg"

class PostgresqlManager

  def initialize(host, database, user, port)
  @connection = PG::Connection.open(:host => host, :dbname =>  database, :user => user, :port => port)
  end

  def create_new_user(username, password)
    results = @connection.exec "CREATE ROLE #{username} WITH password '#{password}' LOGIN"
    @connection.close()
  end

end



