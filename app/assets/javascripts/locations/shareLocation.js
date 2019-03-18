$(".locations-index").ready(function() {
  var container = document.getElementById('popup');
  var content = document.getElementById('popup-content');
  var closer = document.getElementById('popup-closer');
  var form = $('form[name=share-location]')

  /**
   * Create an overlay to anchor the popup to the map.
   */
  var overlay = new ol.Overlay({
    element: container,
    id: 'current-location-popup',
    autoPan: true,
    autoPanAnimation: {
      duration: 250
    }
  });


  /**
   * Add a click handler to hide the popup.
   * @return {boolean} Don't follow the href.
   */
  closer.onclick = function() {
    overlay.setPosition(undefined);
    closer.blur();
    return false;
  };

  /**
   * Add a click handler to the map to render the popup.
   */
  map.on('singleclick', function(evt) {
    if (map.getOverlayById('current-location-popup') == null) {
      map.addOverlay(overlay);
    }

    var coordinate = evt.coordinate;
    var latLongCoordinate = ol.proj.toLonLat(coordinate);
    var hdms = ol.coordinate.toStringHDMS(latLongCoordinate);
    form.append($('<input>').attr({
        type: 'hidden',
        id: 'longitude',
        name: 'longitude',
        value: latLongCoordinate[0]
    }));

    form.append($('<input>').attr({
        type: 'hidden',
        id: 'latitude',
        name: 'latitude',
        value: latLongCoordinate[1]
    }));

    content.innerHTML = '<p>You clicked here:</p><code>' + hdms + '</code>';
    overlay.setPosition(coordinate);
    // $('.share-btn').on('click', function() {
    //   form.submit();
    // });
  });

  $.ajax({
    url: 'locations/public_locations',
    method: 'GET',
    success: function(response) {
      if (response.success) {
        response.locations_shared_by_me.forEach(function(location) {
          addMapPoint(map, location.latitude, location.longitude, 'red');
        })

        response.locations_shared_with_me.forEach(function(location) {
          addMapPoint(map, location.latitude, location.longitude, 'black');
        })

      }
    }
  });
})