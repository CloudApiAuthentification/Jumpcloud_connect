h1 Sign Up

- if user.errors
  ul.errors
  - user.errors.each do |error|
    li = error.to_s

form action="/registration" method="post"
  == csrf_tag
  .form-group
    input.form-control type="email" name="email" placeholder="Email" value=#user.email
  .form-group.d-none
    input.form-control type="text" name="external_id" value=#user.external_id
  .form-group
    input.form-control type="password" name="password" placeholder="Password"
  button.btn.btn-primary.btn-sm type="submit"
    | Register
<hr/>
== link_to("Already have an account?", "/signin")
