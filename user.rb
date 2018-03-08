require "./db_commands"

class User


  def initialize(email)
    @email = email
  end

  def save
    insert_user(@email)
  end

  def self.create(email)
    insert_user(@email)
  end

end
