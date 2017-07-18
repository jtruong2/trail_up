var map;
var markers;
var coordinateLocation = { lat: 39.742043, lng: -104.991531 }

var check_image = function(trail) {
    if (trail.hp_image.length === 0) {
        return '/assets/logo_trail_up.png'
    } else {
        return trail.hp_image
    }
}

function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: coordinateLocation,
        mapTypeId: 'terrain',
        zoom: 9
    });

    var trailheads = $.getJSON('/api/trails/search', {
        search: {
            lat: coordinateLocation.lat,
            lon: coordinateLocation.lng
        }
    }, callback);


    function callback(data) {

        markers = data.map(function(datum) {
            var image = check_image(datum)
            var data_obj = JSON.stringify(datum)
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
                <a href="/trails/select/new?trail=${encodeURI(data_obj)}">Select For Event</a>
                <a href="/directions?orig_lat=${coordinateLocation.lat}&orig_lng=${coordinateLocation.lng}&dest_lat=${datum.lat}&dest_lng=${datum.long}">Directions</a>
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
                // var div = document.getElementById(this.id);
                // div.scrollIntoView(true);
                // console.log(element.data_object)
            });
        }, this);

        var infoWindow = new google.maps.InfoWindow()
        var markerCluster = new MarkerClusterer(map, markers, { imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m' });

        var locationSearch = document.getElementById('location-search-box')
        var searchButton = document.getElementById('location-search-button')

        searchButton.addEventListener('click', function() {
            var searchQuery = locationSearch.value;
            var googleApi = document.getElementById('googleMapApi').textContent;

            $.getJSON(`https://maps.googleapis.com/maps/api/geocode/json?address=${searchQuery}&key=${googleApi}`, locationDump);

            function locationDump(data) {
                coordinateLocation = data.results[0].geometry.location
                    // var infoContainer = document.querySelector('.trail-info')
                    // infoContainer.innerHTML = ''
                return initMap();
            }

        })
    };
};
initMap();