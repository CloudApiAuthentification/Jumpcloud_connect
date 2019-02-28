.row
  .col-sm-11
    h2 Articles
  .col-sm-1
    a.btn.btn-success.btn-sm href="/articles/new" New
.table-responsive
  table.table.table-striped
    thead
      tr
        th Body
        th Group
        th Actions
    tbody
      - articles.each do |article|
        tr
          td = article.body
          td = article.group.id
          td
            span
              == link_to("Show", "/articles/#{article.id}", class: "btn btn-primary btn-sm")
              == link_to("Edit", "/articles/#{article.id}/edit", class: "btn btn-success btn-sm")
              == link_to("Delete", "/articles/#{ article.id }?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
