//= require bootstrap-table/bootstrap-table

// In order for bootstrapTable to work we need to load it on the correct
// turbolinks event.
$(document).on("turbolinks:load", function() {
  $('[data-toggle="table"]').bootstrapTable();
});
