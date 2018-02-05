var requiredFormField = function () {
  $('input[data-required=true]').attr('required', true);
}

$(document).ready(requiredFormField);
$(document).on('page:load', requiredFormField);
