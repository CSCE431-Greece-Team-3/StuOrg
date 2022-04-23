# require "postgresql_manager"
# require "pg_tester"
 
# describe PostgresqlManager do
#   psql = PgTester.new({
#           database: "testbuddy",
#           user: "buddy",
#          })
#   before(:each) do
#     psql.setup
#   end
#   after(:each) do
#     psql.teardown
#   end
#   subject { described_class.new(psql.host, psql.database, psql.user, psql.port) }
#   describe "create_new_user" do
#     context "testing create user method" do
#       it "should create a new user" do
#         subject.create_new_user("derik@gmail.com", "password")
#         result = psql.exec "SELECT usename FROM pg_catalog.pg_user"
#         expect(result.values).to include(["derik@gmail.com"])
#       end
#     end
#   end
#   describe "create_new_user" do
#     context "testing create user method" do
#       it "should create a new user" do
#         subject.create_new_user("anukhatri@gmail.com", "password")
#         result2 = psql.exec "SELECT passwd FROM pg_catalog.pg_user"
#         expect(result2.values).to include (["********"])
#       end
#     end
#   end
# end