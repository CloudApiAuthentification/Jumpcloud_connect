h1 Sign In

- if user.errors
  ul.errors
  - user.errors.each do |error|
    li = error.to_s

form action="/find_where_you_go" method="post"
  == csrf_tag
  .form-group
    input.form-control type="email" name="email" placeholder="Email"
  button.btn.btn-primary.btn-sm type="submit" Next
