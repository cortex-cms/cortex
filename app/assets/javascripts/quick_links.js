(function (global) {
  'use strict';

  $(document).ready(function() {
    $('.quick-links .jumbo-button').mousedown(function () {
      $(this).find('.jumbo-button__content__icon').css('display', 'none');
      $(this).find('.jumbo-button__content__add').css('display', 'block');
    }).bind('mouseup mouseleave', function () {
      $(this).find('.jumbo-button__content__icon').css('display', 'block');
      $(this).find('.jumbo-button__content__add').css('display', 'none');
    });
  });
}(this));
