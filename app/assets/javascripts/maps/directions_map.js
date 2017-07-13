function initDirMap() {
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 14,
        center: {
            lat: 37.77,
            lng: -122.447
        }
    });
    var directionsService = new google.maps.DirectionsService;
    var directionsDisplay = new google.maps.DirectionsRenderer({
        draggable: true,
        map: map,
        panel: document.getElementById('right-panel')
    });

    // directionsDisplay.setMap(map);

    directionsDisplay.addListener('directions_changed', function() {
        computeTotalDistance(directionsDisplay.getDirections());
    });


    displayRoute(directionsService, directionsDisplay);
    // calculateAndDisplayRoute(directionsService, directionsDisplay);
    document.getElementById('mode').addEventListener('change', function() {
        displayRoute(directionsService, directionsDisplay);
    });
}

function displayRoute(service, display) {
    var selectedMode = document.getElementById('mode').value;
    var params = new URLSearchParams(window.location.search)
    var selectedMode = document.getElementById('mode').value;
    service.route({
        origin: {
            lat: parseFloat(params.get('orig_lat')),
            lng: parseFloat(params.get('orig_lng'))
        },
        destination: {
            lat: parseFloat(params.get('dest_lat')),
            lng: parseFloat(params.get('dest_lng'))
        },
        travelMode: google.maps.TravelMode[selectedMode],
        avoidTolls: true
    }, function(response, status) {
        if (status === 'OK') {
            display.setDirections(response);
        } else {
            alert('Could not display directions due to: ' + status);
        }
    });
}

function computeTotalDistance(result) {
    var total = 0;
    var myroute = result.routes[0];
    for (var i = 0; i < myroute.legs.length; i++) {
        total += myroute.legs[i].distance.value;
    }
    total = total / 1000;
    document.getElementById('total').innerHTML = total + ' km';
}

// function calculateAndDisplayRoute(directionsService, directionsDisplay) {
//     var params = new URLSearchParams(window.location.search)
//     var selectedMode = document.getElementById('mode').value;
//     directionsService.route({
//         origin: {
//             lat: parseFloat(params.get('orig_lat')),
//             lng: parseFloat(params.get('orig_lng'))
//         },
//         destination: {
//             lat: parseFloat(params.get('dest_lat')),
//             lng: parseFloat(params.get('dest_lng'))
//         },
//         travelMode: google.maps.TravelMode[selectedMode]
//     }, function(response, status) {
//         if (status == 'OK') {
//             directionsDisplay.setDirections(response);
//         } else {
//             window.alert('Directions request failed due to ' + status);
//         }
//     });
// }