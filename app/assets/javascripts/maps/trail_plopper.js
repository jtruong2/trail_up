var map;
var markers;
var plopLocation;
var coordinateLocation = { lat: 39.742043, lng: -104.991531 }

function plopMarkerMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: coordinateLocation,
        mapTypeId: 'terrain',
        zoom: 9
    });

    var trailheads = $.getJSON('/api/all_trails', coordinateLocation, callback);

    function callback(data) {

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

        markers.forEach(function(element) {
            google.maps.event.addListener(element, 'click', function() {
                infoWindow.setContent(this.customInfo)
                infoWindow.open(map, element);
                map.setCenter(element.getPosition());
            });
        }, this);

        var infoWindow = new google.maps.InfoWindow()
        var markerCluster = new MarkerClusterer(map, markers, { imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m' });

        var locationSearch = document.getElementById('location-search-box')
        var searchButton = document.getElementById('location-search-button')

        searchButton.addEventListener('click', function() {
            var searchQuery = locationSearch.value
            $.getJSON(`https://maps.googleapis.com/maps/api/geocode/json?address=${searchQuery}&key=AIzaSyCwdTm2xiTCPxTGZr_O7HsvVaQb8nKrS3o`, locationDump);

            function locationDump(data) {
                coordinateLocation = data.results[0].geometry.location
                return initMap();
            }

        })
    };

    google.maps.event.addListener(map, 'click', function(event) {
        marker = new google.maps.Marker({
            position: event.latLng,
            map: map
        });

        plopLocation = {
          lat: marker.getPosition().lat(),
          lng: marker.getPosition().lng()
        };
    });

    var submitButton = document.getElementById('submit');

    submitButton.addEventListener('click', function (){
      var location = document.getElementById('plop_location');
      location.value = JSON.stringify(plopLocation);
      // $.get('/trails/get_location', plopLocation)
    })
}


