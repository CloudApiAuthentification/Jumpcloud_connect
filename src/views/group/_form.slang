- if group.errors
  ul.errors
    - group.errors.each do |error|
      li = error.to_s

== form(action: "/groups/#{group.id.to_s}", method: group.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == text_field(name: "name", value: group.name, placeholder: "Name", class: "form-control")
  .form-group
    == text_field(name: "external_id", value: group.external_id, placeholder: "External_id", class: "form-control")
  == submit("Submit", class: "btn btn-primary btn-sm")
  == link_to("Back", "/groups", class: "btn btn-light btn-sm")
