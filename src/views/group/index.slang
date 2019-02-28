.row
  .col-sm-11
    h2 Groups
  .col-sm-1
    a.btn.btn-success.btn-sm href="/groups/new" New
.table-responsive
  table.table.table-striped
    thead
      tr
        th Name
        th External_id
        th Actions
    tbody
      - groups.each do |group|
        tr
          td = group.name
          td = group.external_id
          td
            span
              == link_to("Show", "/groups/#{group.id}", class: "btn btn-primary btn-sm")
              == link_to("Edit", "/groups/#{group.id}/edit", class: "btn btn-success btn-sm")
              == link_to("Delete", "/groups/#{ group.id }?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
