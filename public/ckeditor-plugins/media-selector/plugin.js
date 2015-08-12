(function (global) {
  'use strict';

  global.CKEDITOR.plugins.add('media-selector', {
    icons: 'media',
    init: function (editor) {
      editor.addCommand('insertMedia', {
        exec: function (editor) {
          var mediaLibraryModal = $('#media-library-modal');
          mediaLibraryModal.openModal();

          global.media_select = {};
          global.media_select_defer = $.Deferred();
          global.media_select_defer.promise(global.media_select);

          global.media_select.done(function (media) {
            var media_html = '<img src="' + media.url + '" data-media-id="' + media.id + '" alt="' + media.name + '"></img>';
            editor.insertHtml(media_html);

            mediaLibraryModal.closeModal();
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
