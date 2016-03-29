$(document).ready(function () {
  $('select').material_select();
  $('.modal-trigger').leanModal({
    dismissible: true
  });
  $('.datepicker').pickadate({
    selectMonths: true, // Creates a dropdown to control month
    selectYears: 15 // Creates a dropdown of 15 years to control year
  });
});

function closeTransactionModal() {
  $('#transaction-modal').closeModal();
  document.getElementById('transaction-form').reset()
}
