require 'pg'

# Select statements return a PG::Value object.
# PG::Value.values returns a nested array, with inner arrays representing a row of results.
# Rows are returned in column order

# id, email, num_license_keys_sent
def insert_user(con, email_address)
  result = con.exec "SELECT MAX(id) FROM users"
  p result.values
  id = result.values[0][0].to_i + 1
  con.exec "INSERT INTO users VALUES(#{id},'#{email_address}', 0)"
end

def increment_user_num_license_keys_sent(con, id)
  num_license_keys_sent = (con.exec "SELECT num_license_keys_sent FROM users WHERE id = #{id}").values[0][0].to_i
  con.exec "UPDATE users SET num_license_keys_sent = #{num_license_keys_sent + 1} WHERE id = #{id}"
end

def find_user_by_id(con, id)
  (con.exec "SELECT * FROM users WHERE id = #{id}").values[0]
end

def find_user_by_email(con, email)
  (con.exec "SELECT * FROM users WHERE email_address = #{email}").values[0]
end

def insert_license_key(con, user_id, license_key)
  result = con.exec "SELECT MAX(id) FROM license_keys"
  id = result.values[0][0].to_i + 1
  con.exec "INSERT INTO license_keys VALUES(#{id},#{user_id},'#{license_key}')"
end

def find_license_key_by_user_id(con, user_id)
  (con.exec "SELECT * FROM license_keys WHERE user_id = #{user_id}").values[0]
end

def find_license_key_by_id(con, id)
  (con.exec "SELECT * FROM license_keys WHERE id = #{id}").values[0]
end

def insert_order(con, customer_id, shop_id)
  result = con.exec "SELECT MAX(id) FROM orders"
  id = result.values[0][0].to_i + 1
  con.exec "INSERT INTO orders VALUES(#{id},#{customer_id},#{shop_id})"
end

def find_order_by_id(con, id)
  (con.exec "SELECT * FROM orders WHERE id = #{id}").values[0]

end
def find_order_by_customer_id(con, customer_id)
  (con.exec "SELECT * FROM orders WHERE customer_id = #{customer_id}").values[0]

end
def find_order_by_shop_id(con, shop_id)
  (con.exec "SELECT * FROM orders WHERE shop_id = #{shop_id}").values[0]
end
