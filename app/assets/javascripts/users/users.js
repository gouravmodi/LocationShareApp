$(".users-show").ready(function() {
  var map = createMap();
  var userId = $('#user_id').val();
  var url = 'users/' + userId + '/locations';
  $.ajax({
    url: url,
    method: 'GET',
    success: function(response) {
      if (response.success) {
        response.locations.forEach(function(location) {
          addMapPoint(map, location.latitude, location.longitude, 'green');
        })
      }
    }
  });
});