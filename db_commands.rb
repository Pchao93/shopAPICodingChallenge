require 'pg'

# id, email, num_license_keys_sent
def insert_user(con, email_address)
  id = con.exec "SELECT MAX(id) FROM users"
  con.exec "INSERT INTO users VALUES(#{id},'#{email_address}', 0)"
end

def insert_license_key(con, user_id, license_key)
  id = con.exec "SELECT MAX(id) FROM license_keys"
  con.exec "INSERT INTO license_keys VALUES(#{id},#{user_id},'#{license_key}')"

end

def insert_order(con, customer_id, shop_id)
  id = con.exec "SELECT MAX(id) FROM orders"
  con.exec "INSERT INTO orders VALUES(#{id},#{customer_id},#{shop_id})"
end
