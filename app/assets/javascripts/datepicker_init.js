var datepicker_init = function() {
  var datepicker = $(".datepicker");

  datepicker.datetimepicker({
    dateFormat: "dd/mm/yy",
    onSelect: function (date) {
      var button = $(".new_publish_state_button");

      if (button.length > 0) {
        button.val("schedule");
        button.text("Schedule Post");
      }
    }
  });

  datepicker.on("focusout", function(ev){
    if ($(this).val() === "") {
      $(this).closest('div').addClass('is-dirty');
    }
  });
};

$(document).ready(datepicker_init);
$(document).on('page:load', datepicker_init);
