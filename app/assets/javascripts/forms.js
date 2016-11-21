$(function() {
  // If we restore Turbolinks, all of this should be wrapped in turbolinks:load
  $(".datepicker").datepicker({
    dateFormat: "dd/mm/yy",
    onSelect: function (date) {
      if ($(".new_publish_state_button").length > 0) {
        modifyButton();
      }
    }
  });

  $(".datepicker").on("focusout", function(ev){
    if ($(this).val() == "") {
      $(this).closest('div').addClass('is-dirty');
    }
  });
});

function modifyButton() {
  var button = $(".new_publish_state_button");

  button.val("schedule");
  button.text("Schedule Post");
}
