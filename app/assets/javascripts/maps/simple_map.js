var map;
var markers;



function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: { lat: 39.742043, lng: -104.991531 },
        mapTypeId: 'terrain',
        zoom: 8
    });

    var trailheads = $.getJSON('/api/all_trails', callback);

    // var location = jQuery.parseJSON(document.getElementById('location').textContent)


    // map = new google.maps.Map(document.getElementById('map'), {
    //     center: location,
    //     mapTypeId: 'terrain',
    //     zoom: 8
    // });

    var trailheads = $.getJSON('/api/all_trails', location, callback);


    markers = data.map(function(datum) {
        var marker = new google.maps.Marker({
            position: datum.google_coordinates
        });

        marker.addListener('click', function() {
            infowindow.close();
            infowindow.setContent("<div id='infowindow'>" + datum.name + "</div>");
            infowindow.open(map, this);
            map.setCenter(this.getPosition());
        });

        return marker
    });

    function callback(data) {
        for (i = 0; i < data.length; i++) {
            $('#display-data').append(data[i].name)
        };

        data.forEach(function(element) {
            var infoContainer = document.querySelector('.trail-info')
            var trailInfo = document.createElement('div')
            trailInfo.classList.add('trail')
            trailInfo.innerHTML =
                `     <h3 id=${element.id}>${element.name}</h3>
                <h5><span class='bolden'>Length:</span> ${element.length} <span class='bolden'>| Difficulty:</span> ${element.difficulty} <span class='bolden'>| Rating:</span> ${element.hp_rating}</h5>
                <p>${element.summary}</p>
                
            `
            infoContainer.appendChild(trailInfo)
        })


        markers = data.map(function(datum) {
            return new google.maps.Marker({
                position: datum.google_coordinates,
                customInfo: `
                <div class='map-info'>
                <h3>${datum.name}</h3>
                <h5><span class='bolden'>Length:</span> ${datum.length} <span class='bolden'>| Difficulty:</span> ${datum.difficulty} <span class='bolden'>| Rating:</span> ${datum.hp_rating}</h5>
                <p>${datum.summary}</p>
                </div>
                `,
                id: datum.id
            });
        });

        markers.forEach(function(element) {
            google.maps.event.addListener(element, 'click', function() {
                // infowindow.close();
                var contentString = this.customInfo
                    // var infoWindow = new google.maps.InfoWindow({
                    //     content: contentString
                    // });
                infoWindow.content = contentString
                infoWindow.open(map, element);
                map.setCenter(element.getPosition());
                var div = document.getElementById(this.id)
                div.scrollIntoView(true)
                    // div.parentElement.classList.add('highlight')
            });
        }, this);

        var infoWindow = new google.maps.InfoWindow()
        var markerCluster = new MarkerClusterer(map, markers, { imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m' });
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