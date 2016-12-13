$(document).ready(function(){
  $('#sidebar__toggle-button').on('click', function() {
    $('.layout__container').toggleClass('sidebar--collapsed');
  });
});
