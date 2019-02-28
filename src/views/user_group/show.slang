h1 Show User Group
p = user_group.user.id
p = user_group.group.id
p
  == link_to("Back", "/user_groups", class: "btn btn-light btn-sm")
  == link_to("Edit", "/user_groups/#{user_group.id}/edit", class: "btn btn-success btn-sm")
  == link_to("Delete", "/user_groups/#{user_group.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
