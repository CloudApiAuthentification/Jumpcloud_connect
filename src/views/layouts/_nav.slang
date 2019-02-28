- active = context.request.path == "/" ? "active" : ""
a class="nav-item #{active}" href="/" Home
- if (current_user = context.current_user)
  a.nav-item.nav-item-auth.nav-item-auth-signout href="/signout"
    | Sign Out
  - active = context.request.path == "/profile" ? "active" : ""
  a class="nav-item nav-item-auth nav-item-auth-profile #{active}" href="/profile"
    == current_user.email
- else
  - active = context.request.path == "/signin" ? "active" : ""
  a class="nav-item nav-item-auth nav-item-auth-signin #{active}" href="/signin"
    | Sign In
- active = context.request.path == "/groups" ? "active" : ""
a class="nav-item #{active}" href="/groups" Groups
- active = context.request.path == "/articles" ? "active" : ""
a class="nav-item #{active}" href="/articles" Articles
- active = context.request.path == "/user_groups" ? "active" : ""
a class="nav-item #{active}" href="/user_groups" User Groups
