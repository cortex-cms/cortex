(function (global) {
  'use strict';

  $(document).ready(function() {
    $('.quick-links .jumbo-button').hover(function () {
      $(this).find('.jumbo-button__content__icon').css('display', 'none');
      $(this).find('.jumbo-button__content__add').css('display', 'block');
    }, function () {
      $(this).find('.jumbo-button__content__icon').css('display', 'block');
      $(this).find('.jumbo-button__content__add').css('display', 'none');
    });
  });
}(this));
