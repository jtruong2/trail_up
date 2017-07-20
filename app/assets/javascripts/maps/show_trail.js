var map;
var zoom = 10;
var marker;
let label = 'Trailhead'

var showTrailMap = function() {

    let location = document.getElementById('location').textContent;

    try {
      coordinateLocation = JSON.parse(location);
    } catch(err) {
      coordinateLocation = { lat: 39.742043, lng: -104.991531 };
      label = 'Error'
    };

    map = new google.maps.Map(document.getElementById('map'), {
        center: coordinateLocation,
        mapTypeId: 'terrain',
        zoom: zoom
    });

    marker = new google.maps.Marker({
      position: coordinateLocation,
      map: map,
      label: label
    });

    marker.setMap(map);
};