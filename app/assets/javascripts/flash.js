setTimeout(function(){
  $('.mdl-js-snackbar').toggleClass('mdl-snackbar--active');
}, 2500);

$('.mdl-snackbar__close').click(function(){
  $('.mdl-snackbar').removeClass('mdl-snackbar--active');
})
