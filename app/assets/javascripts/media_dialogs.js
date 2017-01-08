(function (global) {
  'use strict';

  var dialogs = document.querySelectorAll('dialog');
  global.dialogs = {};

  [].forEach.call(dialogs, function(dialog) {
    dialogPolyfill.registerDialog(dialog);
    global.dialogs[dialog.id] = dialog;
  });

  $('.close-dialog').click(function(event) {
    var dialog = document.getElementById(event.target.closest('dialog').id);
    dialog.close();
  })
}(this));
