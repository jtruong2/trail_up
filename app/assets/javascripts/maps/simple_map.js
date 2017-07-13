var map;
var markers;
var coordinateLocation = { lat: 39.742043, lng: -104.991531 }

function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: coordinateLocation,
        mapTypeId: 'terrain',
        zoom: 9
    });

    var trailheads = $.getJSON('/api/all_trails', coordinateLocation, callback);

    function callback(data) {
        for (i = 0; i < data.length; i++) {
            $('#display-data').append(data[i].name)
        };

        // data.forEach(function(element) {
        //     var infoContainer = document.querySelector('.trail-info')
        //     var trailInfo = document.createElement('div')
        //     trailInfo.classList.add('trail')
        //     trailInfo.innerHTML =
        //         `     <h3 id=${element.id}>${element.name}</h3>
        //         <h5><span class='bolden'>Length:</span> ${element.length} <span class='bolden'>| Difficulty:</span> ${element.difficulty} <span class='bolden'>| Rating:</span> ${element.hp_rating}</h5>
        //         <p>${element.summary}</p>

        //     `
        //     infoContainer.appendChild(trailInfo)
        // })


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
                var contentString = this.customInfo
                infoWindow.setContent(contentString)
                infoWindow.open(map, element);
                map.setCenter(element.getPosition());
                var div = document.getElementById(this.id);
                div.scrollIntoView(true);
                console.log(element.data_object)
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
                    // var infoContainer = document.querySelector('.trail-info')
                    // infoContainer.innerHTML = ''
                return initMap();
            }

        })
    };


    // google.maps.event.addListener(map, 'click', function(event) {
    //     marker = new google.maps.Marker({
    //         position: event.latLng,
    //         map: map
    //     });

    //     google.maps.event.addListener(marker, 'click', function() {
    //         infowindow.open(map, marker);
    //     });
    // });
}