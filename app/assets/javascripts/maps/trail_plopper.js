var map; // main google map object
var plopMarker; // holds the user plopped marker for location of trail
var plopLocation; // holds the location of the plopMarker to send to DOM
var new_coordinateLocation;
var markers; // holds all markers from HikingProject API call
var zoom = 9;

var coordinateLocation = { lat: 39.742043, lng: -104.991531 };
var new_coordinateLocation = coordinateLocation

var check_image = function(trail) {
    if (trail.hp_image.length === 0) {
        return '/assets/logo_trail_up.png'
    } else {
        return trail.hp_image
    }
};

// clears all markers in the marker array

const clearPlopMarker = function() {
  if(plopMarker) { plopMarker.setMap(null) }
};

// main function to initialize, listen, and refresh google map

function plopMarkerMap() {
    // initialize map

    map = new google.maps.Map(document.getElementById('map'), {
        center: coordinateLocation,
        mapTypeId: 'terrain',
        zoom: zoom
    });

    // JSON get request to HikingProject

    let trailheads = $.getJSON('/api/trails/search',
      { search:
        { lat: new_coordinateLocation.lat,
          lon: new_coordinateLocation.lng,
          maxDistance: 1 }}, callback );

    // if JSON request is successfull this method builds markers and places them on the map

    function callback(data) {

        // creates all markers based on trailhead query with customInfo for infoWindow

        markers = data.map(function(datum) {
            let image = check_image(datum);
            return new google.maps.Marker({
                position: datum.google_coordinates,
                customInfo: `
                <div class='map-info'>
                <div class='map-info-header'>
                <img src=${image} alt='Trail Image'>
                <h3>${datum.name}</h3>
                </div>
                <h5><span class='bolden'>Length:</span> ${datum.length} <span class='bolden'>| Difficulty:</span> ${datum.difficulty} <span class='bolden'>| Rating:</span> ${datum.hp_rating}</h5>
                <p>${datum.summary}</p>
                <div class='links'>
                <a href="/event/new?trail=${datum.hp_id}">Select For Event</a>
                <a href="/directions?orig_lat=${coordinateLocation.lat}&orig_lng=${coordinateLocation.lng}&dest_lat=${datum.lat}&dest_lng=${datum.long}">Directions</a>
                </div>
                </div>
                `,
                id: datum.hp_id,
                data_object: datum
            });
        });

        // sets info windows and listener to open window on each marker

        markers.forEach(function(marker) {
            google.maps.event.addListener(marker, 'click', function() {
                infoWindow.setContent(this.customInfo)
                infoWindow.open(map, marker);
                map.setCenter(element.getPosition());
            });
        }, this);

        let infoWindow = new google.maps.InfoWindow()

        // places all markers from trailhead query

        markers.forEach(function(marker) {
          marker.setMap(map);
        });

        // places plopMarker

        if (plopMarker) { plopMarker.setMap(map) };

        // submits a query to google based on address and refreshes map at the result

        let locationSearch = document.getElementById('location-search-box')
        let searchButton = document.getElementById('location-search-button')

        searchButton.addEventListener('click', function() {
            let searchQuery = locationSearch.value
            let googleApi = document.getElementById('googleMapApi').textContent;

            $.getJSON(`https://maps.googleapis.com/maps/api/geocode/json?address=${searchQuery}&key=${googleApi}`, locationDump);

            function locationDump(data) {
                coordinateLocation = data.results[0].geometry.location
                debugger
                return plopMarkerMap();
            }

        })
    };

    // places new marker and refreshes map with trails nearby

    google.maps.event.addListener(map, 'click', function(event) {
        clearPlopMarker();

        plopMarker = new google.maps.Marker({
            position: event.latLng,
            map: map,
            zIndex: 1000,
            draggable: true,
            icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png'
        });

        plopLocation = {
          lat: plopMarker.getPosition().lat(),
          lng: plopMarker.getPosition().lng()
        };

        new_coordinateLocation = plopLocation
        zoom = map.zoom;

        plopMarker.addListener('dragend', function(event) {
          clearPlopMarker();

          plopMarker.position = event.latLng;

          plopLocation = {
            lat: plopMarker.getPosition().lat(),
            lng: plopMarker.getPosition().lng()
          };

          new_coordinateLocation = plopLocation
          zoom = map.zoom;
          plopMarkerMap();
        });

        plopMarkerMap();
    });

    // sends plopLocation of marker to DOM to so Rails can send in create trail form

    let submitButton = document.getElementById('submit');

    submitButton.addEventListener('click', function (){
      let location = document.getElementById('plop_location');
      location.value = JSON.stringify(plopLocation);
    });
};