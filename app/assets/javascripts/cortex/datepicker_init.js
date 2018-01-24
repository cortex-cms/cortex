var datepicker_init = function () {
  var datepicker = $('.datepicker');

  if (datepicker.length) {
    datepicker.datetimepicker({
      dateFormat: 'dd/mm/yy',
      timeFormat: 'HH:mm Z',
      onSelect: function (date) {
        var button = $('.form-button--submission');
        button.text('Schedule Post');
        button.val('schedule');
      }
    });

    datepicker.on('focusout', function (ev) {
      if ($(this).val() === "") {
        var button = $('.form-button--submission');

        button.text('Save Now');
        button.val('draft');

        $(this).closest('div').addClass('is-dirty');
      }
    });
  }
};

$(document).ready(datepicker_init);
$(document).on('page:load', datepicker_init);
