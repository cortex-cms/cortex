$(function() {
  $(".datepicker").datepicker({
    dateFormat: "dd/mm/yy"
  });

  $(".datepicker").on("click", function(ev){
    if ($(this).val() == "") {
      $(this).closest('div').addClass('is-dirty');
    }
  })
});
