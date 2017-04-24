var datepicker_init = function() {
  var datepicker = $('.datepicker');

  if (datepicker.length) {
    datepicker.datetimepicker({
      dateFormat: 'dd/mm/yy',
      timeFormat: 'HH:mm Z'
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
