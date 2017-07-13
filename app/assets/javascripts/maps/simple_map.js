var map;
var markers;

function initMap() {

  var location = jQuery.parseJSON(document.getElementById('location').textContent)


  map = new google.maps.Map(document.getElementById('map'), {
    center: location,
    mapTypeId: 'terrain',
    zoom: 8
  } );

  var trailheads = $.getJSON('api/all_trails', location, callback);

  function callback(data) {
    for(i = 0; i < data.length; i ++) {
      $('#display-data').append(data[i].name )
    };

    markers = data.map( function(datum) {
      var marker =  new google.maps.Marker({
        position: datum.google_coordinates
      });

      marker.addListener('click', function(){
        infowindow.close();
        infowindow.setContent( "<div id='infowindow'>" + datum.name + "</div>");
        infowindow.open(map, this);
        map.setCenter(this.getPosition());
      });

      return marker
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

  var infowindow = new google.maps.InfoWindow();
}