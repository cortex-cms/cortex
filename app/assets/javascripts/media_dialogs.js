(function (global) {
  'use strict';

  var dialogs = document.querySelectorAll('dialog');
  global.dialogs = {};

  [].forEach.call(dialogs, function(dialog) {
    dialogPolyfill.registerDialog(dialog);
    global.dialogs[dialog.id] = dialog;
  });

  $('.close-dialog').on('click', function(event) {
    closeDialog(event);
  });

  $('body').on('click', function(event) {
    var dialog = document.getElementById(event.target.closest('dialog').id);
    var rect = dialog.getBoundingClientRect();
    var isInDialog=(rect.top <= event.clientY && event.clientY <= rect.top + rect.height && rect.left <= event.clientX && event.clientX <= rect.left + rect.width);

    if (!isInDialog) {
      closeDialog(event);
    }
  });

  global.blur_backdrop = function() {
    $('.mdl-layout__container').addClass('blur');
  };

  global.unblur_backdrop = function() {
    $('.mdl-layout__container').removeClass('blur');
  };

  function closeDialog(event) {
    var dialog = document.getElementById(event.target.closest('dialog').id);
    dialog.close();
    global.unblur_backdrop();
  }
}(this));
