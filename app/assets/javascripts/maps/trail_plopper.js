var map; // main google map object
var plopMarker; // holds the user plopped marker for location of trail
var plopLocation; // holds the location of the plopMarker to send to DOM
var markers; // holds all markers from HikingProject API call
var zoom = 9;

var coordinateLocation = { lat: 39.742043, lng: -104.991531 }

// main function to initialize, listen, and refresh google map

function plopMarkerMap() {
    // initialize map

    map = new google.maps.Map(document.getElementById('map'), {
        center: coordinateLocation,
        mapTypeId: 'terrain',
        zoom: zoom
    });

    // JSON get request to HikingProject

    var trailheads = $.getJSON('/api/trails/search',
      { search:
        { lat: coordinateLocation.lat,
          lon: coordinateLocation.lng,
          maxDistance: 1 }}, callback );

    // if JSON request is successfull this method builds markers and places them on the map

    function callback(data) {

        // creates all markers based on trailhead query with customInfo for infoWindow

        markers = data.map(function(datum) {
            return new google.maps.Marker({
                position: datum.google_coordinates,
                customInfo: `
                <div class='map-info'>
                <div class='map-info-header'>
                <img src=${datum.hp_image} alt='Trail Image'>
                <h3>${datum.name}</h3>
                </div>
                <h5><span class='bolden'>Length:</span> ${datum.length} <span class='bolden'>| Difficulty:</span> ${datum.difficulty} <span class='bolden'>| Rating:</span> ${datum.hp_rating}</h5>
                <p>${datum.summary}</p>
                <div class='links'>
                <a href="/event/new?trail=${datum.hp_id}">Select For Event</a>
                <a href="/directions?lat=${datum.lat}&lng=${datum.long}">Directions</a>
                </div>
                </div>
                `,
                id: datum.hp_id,
                data_object: datum
            });
        });

        // sets info windows and listener to open window on each marker

        markers.forEach(function(element) {
            google.maps.event.addListener(element, 'click', function() {
                infoWindow.setContent(this.customInfo)
                infoWindow.open(map, element);
                map.setCenter(element.getPosition());
            });
        }, this);

        var infoWindow = new google.maps.InfoWindow()

        // places all markers from trailhead query

        markers.forEach(function(marker) {
          marker.setMap(map);
        });

        // places plopMarker

        if (plopMarker) { plopMarker.setMap(map) };

        // submits a query to google based on address and refreshes map at the result

        var locationSearch = document.getElementById('location-search-box')
        var searchButton = document.getElementById('location-search-button')

        searchButton.addEventListener('click', function() {
            var searchQuery = locationSearch.value
            $.getJSON(`https://maps.googleapis.com/maps/api/geocode/json?address=${searchQuery}&key=AIzaSyDht8iugiUFeEDKrSPQUo5vIrBmwqlqB1o`, locationDump);

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
            icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png'
        });

        plopLocation = {
          lat: plopMarker.getPosition().lat(),
          lng: plopMarker.getPosition().lng()
        };

        coordinateLocation = plopLocation;
        zoom = map.zoom;
        plopMarkerMap();
    });

    // sends plopLocation of marker to DOM to so Rails can send in create trail form

    var submitButton = document.getElementById('submit');

    submitButton.addEventListener('click', function (){
      var location = document.getElementById('plop_location');
      location.value = JSON.stringify(plopLocation);
    });
}

// clears all markers in the marker array

function clearPlopMarker() {
  if(plopMarker) { plopMarker.setMap(null) }
};