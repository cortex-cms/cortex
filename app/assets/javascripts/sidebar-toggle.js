$(document).ready(function(){
  $('#sidebar__toggle-button').on('click', function() {
    $('body').toggleClass('sidebar--collapsed');
  });
});
