var map; // main google map object
var plopMarker; // holds the user plopped marker for location of new trail
var markers; // holds all markers built from HikingProject API call
var zoom = 10; // default map zoom

// object that can act like a marker event so it can be used to create a plopMarker

class PlopLocation {
  constructor(lat, lng) {
    this.latLng = { lat: lat, lng: lng}
  }
};

var searchLocation = new PlopLocation(39.742043, -104.991531);

var check_image = function(trail) {
    if (trail.hp_image.length === 0) {
        return '/assets/logo_trail_up.png'
    } else {
        return trail.hp_image
    }
};

// clears plopped marker from map

const clearPlopMarker = function() {
  if(plopMarker) { plopMarker.setMap(null) }
};

// builds a plop marker from a google map event

const makePlopMarker = function(event) {
  return new google.maps.Marker({
      position: event.latLng,
      map: map,
      zIndex: 1000,
      draggable: true,
      icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png'
  })
};

const trailheadInfoWindow = function(datum) {
  let image = check_image(datum);
  return `
      <div class='map-info'>
      <div class='map-info-header'>
      <img src=${image} alt='Trail Image'>
      <h3>${datum.name}</h3>
      </div>
      <h5><span class='bolden'>Length:</span> ${datum.length} <span class='bolden'>| Difficulty:</span> ${datum.difficulty} <span class='bolden'>| Rating:</span> ${datum.hp_rating}</h5>
      <p>${datum.summary}</p>
      <div class='links'>
      <a href="/event/new?trail=${datum.hp_id}">Select For Event</a>
      <a href="/directions?orig_lat=${searchLocation.latLng.lat}&orig_lng=${searchLocation.latLng.lng}&dest_lat=${datum.lat}&dest_lng=${datum.long}">Directions</a>
      </div>
      </div>
    `
};

// plops a marker down at the events latLng and reloads map

var plopThatMarker = function(event) {
  clearPlopMarker();

  plopMarker = makePlopMarker(event);
  zoom = map.zoom;

  plopMarker.addListener('dragend', function(event) {
    plopThatMarker(event)
  });

  plopMarkerMap();
};

// main function to initialize, listen, and refresh google map

function plopMarkerMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: searchLocation.latLng,
        mapTypeId: 'terrain',
        zoom: zoom
    });

    // Places plopMarker if it exists otherwise makes one from searchLocation

    if (plopMarker) {
      plopMarker.setMap(map)
    } else {
      plopThatMarker(searchLocation)
    };

    // Request to HikingProject for trailheads near plopMarker

    let trailheads = $.getJSON('/api/trails/search',
      { search:
        { lat: plopMarker.getPosition().lat(),
          lon: plopMarker.getPosition().lng(),
          maxDistance: 1 }}, buildMarkers );

    // If request is successfull build markers and place them on map

    function buildMarkers(data) {

        // Fill markers array with markers built from data

        markers = data.map(function(datum) {
            return new google.maps.Marker({
                position: datum.google_coordinates,
                customInfo: trailheadInfoWindow(datum),
                id: datum.hp_id,
                data_object: datum
            });
        });

        // Add listener to each marker for infoWindow popup

        let infoWindow = new google.maps.InfoWindow()

        markers.forEach(function(marker) {
            google.maps.event.addListener(marker, 'click', function() {
                infoWindow.setContent(this.customInfo)
                infoWindow.open(map, marker);
                map.setCenter(element.getPosition());
            });
        }, this);

        // Add each marker to the map

        markers.forEach(function(marker) {
          marker.setMap(map);
        });

        // Listen for search submit to reload map based on user input address

        let searchButton = document.getElementById('location-search-button');

        searchButton.addEventListener('click', function() {
            let searchQuery = document.getElementById('location-search-box').value;
            let googleApi = document.getElementById('googleMapApi').textContent;

            $.getJSON(`https://maps.googleapis.com/maps/api/geocode/json?address=${searchQuery}&key=${googleApi}`, locationDump);

            function locationDump(data) {
                plopMarker = null;
                searchLocation = new PlopLocation( data.results[0].geometry.location.lat,
                                                   data.results[0].geometry.location.lng );
                return plopMarkerMap();
            };

        });
    };

    // Places new plopMarker when user clicks on map

    google.maps.event.addListener(map, 'click', function(event) {
      plopThatMarker(event);
    });

    // Listen for form submit and add plopMarker location to form

    let submitButton = document.getElementById('submit');

    submitButton.addEventListener('click', function (){

      let location = document.getElementById('plop_location');
      location.value = JSON.stringify(plopMarker.latLng);
    });
};
