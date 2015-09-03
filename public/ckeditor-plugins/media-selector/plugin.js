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
            editor.insertHtml(getMediaHtml(media));
            mediaLibraryModal.closeModal();
          });

          var getMediaHtml = function(media) {
            var media_html;

            switch(media.content_type) {
              case 'image':
                media_html = '<img src="' + media.url + '" data-media-id="' + media.id + '" alt="' + media.name + '"></img>';
                break;
              case 'youtube':
                media_html = '<iframe data-media-id="' + media.id + '" type="text/html" src="http://www.youtube.com/embed/' + media.video_id + '" frameborder="0" style="width: 100%; height: auto;" />';
                break;
              case 'pdf':
                media_html = '<a href="' + media.url + '" data-media-id="' + media.id + '">' + media.name + '</a>';
                break;
            }

            return media_html;
          }
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
