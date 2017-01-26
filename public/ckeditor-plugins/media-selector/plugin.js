(function (global) {
  'use strict';

  global.CKEDITOR.plugins.add('media-selector', {
    icons: 'media',
    init: function (editor) {
      editor.addCommand('insertMedia', {
        exec: function (editor) {
          var mediaLibraryModal = $('#media-library-modal');
          mediaLibraryModal.modal('open');

          global.media_select = {};
          global.media_select_defer = $.Deferred();
          global.media_select_defer.promise(global.media_select);

          global.media_select.done(function (media) {
            editor.insertHtml(global.utility.getMediaHtml(media));
            mediaLibraryModal.modal('close');
          });
        }
      });

      editor.ui.addButton('Media', {
        label: 'Insert Media',
        command: 'insertMedia',
        toolbar: 'insert'
      });
    }
  });
}(this));
