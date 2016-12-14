(function() {
  // See: http://stackoverflow.com/questions/32923179/material-design-lite-not-working-with-turbolinks

    document.addEventListener("turbolinks:load", function() {
        console.log('It works on each visit!');
        componentHandler.upgradeDom();
        window.setModals()
        window.setDatePickers();
    });

})();
