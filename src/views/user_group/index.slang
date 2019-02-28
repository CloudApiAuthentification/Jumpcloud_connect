.row
  .col-sm-11
    h2 User Groups
  .col-sm-1
    a.btn.btn-success.btn-sm href="/user_groups/new" New
.table-responsive
  table.table.table-striped
    thead
      tr
        th User
        th Group
        th Actions
    tbody
      - user_groups.each do |user_group|
        tr
          td = user_group.user.id
          td = user_group.group.id
          td
            span
              == link_to("Show", "/user_groups/#{user_group.id}", class: "btn btn-primary btn-sm")
              == link_to("Edit", "/user_groups/#{user_group.id}/edit", class: "btn btn-success btn-sm")
              == link_to("Delete", "/user_groups/#{ user_group.id }?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
