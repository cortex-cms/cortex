(function (global) {
  'use strict';

  global.CKEDITOR.plugins.add('media-selector', {
    icons: 'media',
    init: function (editor) {
      editor.addCommand('insertMedia', {
        exec: function (editor) {
          console.log(this);















          global.utility.currentEditor = editor;
          global.utility.mediaLibraryModal = $('#media-library-modal');

          global.utility.mediaLibraryModal.openModal();
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
