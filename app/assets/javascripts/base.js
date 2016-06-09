(function() {
  // See: http://stackoverflow.com/questions/32923179/material-design-lite-not-working-with-turbolinks
  document.addEventListener('turbolinks:load', function() {
    componentHandler.upgradeDom();
  });
})();
