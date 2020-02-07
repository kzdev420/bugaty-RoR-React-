module UsersHelper
  def username(user)
    "#{user.first_name} #{user.last_name}"
  end
end
