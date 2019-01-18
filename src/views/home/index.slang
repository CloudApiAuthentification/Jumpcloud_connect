.row
  = users = User.all
  - users.each do |user|
    = user.email
