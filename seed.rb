require 'pg'

# connect to postgres db
postgres = PG.connect(dbname: 'postgres')

# create database if it does not already exist
begin
  postgres.exec("CREATE DATABASE shopapi")

rescue PG::Error => e
  p "DB already initialized"
ensure
  postgres.close if postgres
end

#connect to our database
con = PG.connect(dbname: "shopapi")


p con.server_version

#drop any pre-existing tables
con.exec "DROP TABLE IF EXISTS orders"
con.exec "DROP TABLE IF EXISTS license_keys"
con.exec "DROP TABLE IF EXISTS users"

# create user table
con.exec "CREATE TABLE users(id INTEGER PRIMARY KEY,
        email_address VARCHAR(255), num_license_keys_sent INTEGER)"

# add indices and uniqueness constraints
con.exec "CREATE UNIQUE INDEX index_users_on_id ON users (id);"
con.exec "CREATE UNIQUE INDEX index_users_on_email_address ON users (email_address);"

# insert seed data
con.exec "INSERT INTO users VALUES(1,'user1@test.com',0)"
con.exec "INSERT INTO users VALUES(2,'user2@test.com',1)"
con.exec "INSERT INTO users VALUES(3,'user3@test.com',1)"
con.exec "INSERT INTO users VALUES(4,'user4@test.com',1)"
con.exec "INSERT INTO users VALUES(5,'cool_shop@test.com',0)"
con.exec "INSERT INTO users VALUES(6,'bad_shop@test.com',0)"

# create license_key table
con.exec "CREATE TABLE license_keys(id INTEGER PRIMARY KEY, user_id INTEGER REFERENCES users(id),
        license_key VARCHAR(255))"

# add indices and uniqueness constraints
con.exec "CREATE UNIQUE INDEX index_license_keys_on_id ON license_keys (id);"
con.exec "CREATE INDEX index_license_keys_on_user_id ON license_keys (user_id);"
con.exec "CREATE UNIQUE INDEX index_license_keys_on_license_key ON license_keys (license_key);"

# insert seed data
con.exec "INSERT INTO license_keys VALUES(1,2,'donkey')"
con.exec "INSERT INTO license_keys VALUES(2,3,'cat')"
con.exec "INSERT INTO license_keys VALUES(3,4,'dog')"

# create orders table
con.exec "CREATE TABLE orders(id INTEGER PRIMARY KEY, customer_id INTEGER REFERENCES users(id),
        shop_id INTEGER REFERENCES users(id))"

# add indices and uniqueness constraints
con.exec "CREATE UNIQUE INDEX index_orders_on_id ON orders (id);"
con.exec "CREATE INDEX index_orders_on_customer_id ON orders (customer_id);"
con.exec "CREATE INDEX index_orders_on_shop_id ON orders (shop_id);"

# insert seed data
con.exec "INSERT INTO orders VALUES(1,2,1)"
con.exec "INSERT INTO orders VALUES(2,3,1)"
con.exec "INSERT INTO orders VALUES(3,4,2)"


#close database connection
con.close
