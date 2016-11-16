$(function() {
  // If we restore Turbolinks, all of this should be wrapped in turbolinks:load
  $(".datepicker").datetimepicker({
    dateFormat: "dd/mm/yy"
  });

  $(".datepicker").on("focus", function(ev){
    if ($(this).val() == "") {
      $(this).closest('div').addClass('is-dirty');
    }
  })
});
