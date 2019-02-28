- if user_group.errors
  ul.errors
    - user_group.errors.each do |error|
      li = error.to_s

== form(action: "/user_groups/#{user_group.id.to_s}", method: user_group.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == label(:user)
    == select_field(name: "user_id", collection: User.all.map{|user| [user.id, user.id]}, selected: user_group.user_id, class: "form-control")
  .form-group
    == label(:group)
    == select_field(name: "group_id", collection: Group.all.map{|group| [group.id, group.id]}, selected: user_group.group_id, class: "form-control")
  == submit("Submit", class: "btn btn-primary btn-sm")
  == link_to("Back", "/user_groups", class: "btn btn-light btn-sm")
