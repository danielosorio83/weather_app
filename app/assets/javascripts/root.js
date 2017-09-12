$("#random-city").on('click', function(e){
  e.preventDefault();
  var random = $("#random");
  random.val(true);
  $("#get-weather").trigger('click');
  random.val('');
});