(function () {
  // See: http://stackoverflow.com/questions/32923179/material-design-lite-not-working-with-turbolinks
  $(document).on('turbolinks:load', function () {
    componentHandler.upgradeDom();
  });
})();
