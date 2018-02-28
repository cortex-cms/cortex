
function TreeBranchClicked(nested_id, target) {
  var checked = $(target).find('input[type="checkbox"]')[0].checked;

  $(nested_id).find('input[type="checkbox"]').prop('checked', checked)

  if (checked === true) {
    $(nested_id).find('label').addClass('is-checked');
  } else {
    $(nested_id).find('label').removeClass('is-checked');
  }
}
