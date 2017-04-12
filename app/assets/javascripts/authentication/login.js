$(document).ready(function(){
  $('.login_tab').on('click', function(ev){
    var value = this.text;
    $('#user_email').focus();

    if (value === 'Legacy') {
      $('.legacy_value').val(1)
    } else {
      $('.legacy_value').val(0)
    }
  })
})
