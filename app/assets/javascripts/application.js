// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery-readyselector
//= require_tree .

function addMapPoint(map, lat, lng, color) {
  var feature = new ol.Feature({
    geometry: new ol.geom.Point(ol.proj.transform([parseFloat(lng), parseFloat(lat)], 'EPSG:4326', 'EPSG:3857'))
  });

  feature.setStyle(new ol.style.Style({
    image: new ol.style.Icon(({
      crossOrigin: 'anonymous',
      color: color,
      src: 'https://openlayers.org/en/latest/examples/data/dot.png'
    }))
  }));

  var vectorSource = new ol.source.Vector({
    features: [feature]
  });

  var vectorLayer = new ol.layer.Vector({
    source: vectorSource
  });

  map.addLayer(vectorLayer);
}

function createMap() {
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
  return map;
}