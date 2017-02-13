var datepicker_init = function() {
  var datepicker = $('.datepicker');

  if (datepicker.length) {
    datepicker.datetimepicker({
      dateFormat: 'dd/mm/yy',
      onSelect: function (date) {
        var button = $('.new_publish_state_button');
        var currentDate = new Date();
        var selectedDate = moment(date, 'DD-MM-YYYY HH:mm');

        if (button.length > 0 && selectedDate > currentDate) {
          button.val('schedule');
          button.text('Schedule Post');
        }
        else {
          button.val('published');
          button.text('Publish Now');
        }
      }
    });

    datepicker.on('focusout', function(ev){
      if ($(this).val() === "") {
        $(this).closest('div').addClass('is-dirty');
      }
    });
  }
};

$(document).ready(datepicker_init);
$(document).on('page:load', datepicker_init);
