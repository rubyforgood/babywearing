$(document).ready(function() {
  $(".expander").click(function() {
    $(this).text($(this).text() === '+' ? '-' : '+');
  });
});
