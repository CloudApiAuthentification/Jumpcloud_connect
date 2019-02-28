h1 Show Group
p = group.name
p = group.external_id
p
  == link_to("Back", "/groups", class: "btn btn-light btn-sm")
  == link_to("Edit", "/groups/#{group.id}/edit", class: "btn btn-success btn-sm")
  == link_to("Delete", "/groups/#{group.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
