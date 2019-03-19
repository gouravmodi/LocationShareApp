$(".users-show").ready(function() {
  var map = new ol.Map({
    target: 'map',
    layers: [
      new ol.layer.Tile({
        source: new ol.source.OSM()
      })
    ],
    view: new ol.View({
      center: ol.proj.fromLonLat([79.088860, 21.146633]),
      zoom: 4
    })
  });
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