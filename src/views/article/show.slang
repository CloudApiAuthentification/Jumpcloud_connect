h1 Show Article
p = article.body
p = article.group.id
p
  == link_to("Back", "/articles", class: "btn btn-light btn-sm")
  == link_to("Edit", "/articles/#{article.id}/edit", class: "btn btn-success btn-sm")
  == link_to("Delete", "/articles/#{article.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
