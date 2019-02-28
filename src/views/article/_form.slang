- if article.errors
  ul.errors
    - article.errors.each do |error|
      li = error.to_s

== form(action: "/articles/#{article.id.to_s}", method: article.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == text_area(name: "body", content: article.body, placeholder: "Body", class: "form-control", size: "30x10")
  .form-group
    == label(:group)
    == select_field(name: "group_id", collection: Group.all.map{|group| [group.id, group.id]}, selected: article.group_id, class: "form-control")
  == submit("Submit", class: "btn btn-primary btn-sm")
  == link_to("Back", "/articles", class: "btn btn-light btn-sm")
