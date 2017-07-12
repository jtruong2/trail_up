var map;
var markers;

function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: { lat: 39.742043, lng: -104.991531 },
    mapTypeId: 'terrain',
    zoom: 8
  } );

  var trailheads = $.getJSON('api/all_trails', callback);

  function callback(data) {
    for(i = 0; i < data.length; i ++) {
      $('#display-data').append(data[i].name )
    };

    markers = data.map( function(datum) {
      return new google.maps.Marker({
        position: datum.google_coordinates,
      });
    });

    var markerCluster = new MarkerClusterer(map, markers,
      { imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m' });
  };

  google.maps.event.addListener(map, 'click', function(event) {
    marker = new google.maps.Marker({
    position: event.latLng,
    map: map
    });

    google.maps.event.addListener(marker, 'click', function() {
      infowindow.open(map, marker);
    });
  });
}