// object that can act like a marker event so it can be used to create a plopMarker

class PlopLocation {
  constructor(lat, lng) {
    this.latLng = { lat: lat, lng: lng}
  }
};

class Trail {
  constructor() {
    this.name = 'Trail Name'
    this.length = 8
    this.difficulty = 'Blue'
    this.rating = 'none'
    this.summary = 'A very nice walk in the park'
    this.image = '/assets/logo_trail_up.png'
  };
}

var map; // main google map object
var plopMarker; // holds the user plopped marker for location of new trail
var markers; // holds all markers built from HikingProject API call
var zoom = 10; // default map zoom
var geocoder; // holds instance of GoogleGeocoder
var temp_location; // holds the autoCompleted location from geocoder
var city;
var state;
var trail = new Trail;
var searchLocation = new PlopLocation(39.742043, -104.991531);
var preivew; // holds element preview is placed into

const check_image = function(trail) {
    if (trail.hp_image.length === 0) {
        return '/assets/logo_trail_up.png'
    } else {
        return trail.hp_image
    }
};

// refreshes trail info preview window

const refreshPreview = function() {
  $("#trail-preview").empty();
  preview = trailPreview(trail);
  $("#trail-preview").append(preview);
}

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
      <img src=${image} alt='Trail Image' id='image_prev'>
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

const trailPreview = function(trail) {
  return `
    <div class='map-info'>
      <div class='map-info-header'>
        <img src=${trail.image} alt='Trail Image' id='img_prev'>
        <h3>${trail.name}</h3>
      </div>
      <h5><span class='bolden'>Length:</span> ${trail.length} <span class='bolden'>| Difficulty:</span> ${trail.difficulty} <span class='bolden'>| Rating:</span> ${trail.rating}</h5>
      <p>${trail.summary}</p>
        <div class='links'>
          <a href="/directions?orig_lat=${searchLocation.latLng.lat}&orig_lng=${searchLocation.latLng.lng}&dest_lat=${plopMarker.getPosition().lat()}&dest_lng=${plopMarker.getPosition().lng()}">Directions</a>
        </div>
      </div>
    </div>
  `
}
// plops a marker down at the events latLng and reloads map

var plopThatMarker = function(event) {
  clearPlopMarker();

  plopMarker = makePlopMarker(event);
  zoom = map.zoom;

  plopMarker.addListener('dragend', function(event) {
    plopThatMarker(event)
  });

  let location_field = document.getElementById('trail_location');
  let lat = document.getElementById('trail_latitude');
  let lng = document.getElementById('trail_longitude');
  lat.value = JSON.stringify(plopMarker.position.lat());
  lng.value = JSON.stringify(plopMarker.position.lng());

  // makes a call to googleAPI geocoder based on plopMarker location and
  // fills in location field with the city and state

  geocoder.geocode({'location': plopMarker.position}, function(results, status) {
    results.forEach(function(result) {
      if ( $.inArray( 'street_address', result.types ) >= 0 ) {
        result.address_components.forEach(function(comp) {
          if ( $.inArray( 'locality', comp.types ) >= 0 ) {
            city = comp.long_name
          };
          if ( $.inArray( 'administrative_area_level_1', comp.types ) >= 0 ) {
            state = comp.short_name
          };
        });
      };
    });

    location_field.value = city + ', ' + state
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

    // Add geocoder to make address API calls
    geocoder = new google.maps.Geocoder;
    // Add listener to each marker for infoWindow popup
    let infoWindow = new google.maps.InfoWindow();

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

    // updates the trail preview box
    refreshPreview();

    $('#new_trail').bind('input', function(){
      trail.name = $("#trail_name").val();
      trail.summary = $("#trail_description").val();
      trail.difficulty = $("#trail_difficulty_id").text().split('\n')[$("#trail_difficulty_id").val() - 1];
      trail.length = $("#trail_distance").val();

      refreshPreview();

      google.maps.event.addListener(plopMarker, 'click', function() {
          infoWindow.setContent(trailPreview(trail))
          infoWindow.open(map, plopMarker);
          map.setCenter(plopMarker.getPosition());
      });
    });

    // preview a loaded image

    $("#trail_images_images").change(function() {
      readURL(this);
    });

    const readURL = function(input) {
      var reader;

      if (input.files && input.files[0]) {
        reader = new FileReader();
        reader.readAsDataURL(input.files[0]);

        reader.onload = function(e) {
          trail.image = e.target.result;
          refreshPreview();
        };
      }
    };

    google.maps.event.addListener(map, 'click', function(event) {
      plopThatMarker(event);
    });

    // Listen for form submit and add plopMarker location to form
    let submitButton = document.getElementById('submit');
    submitButton.addEventListener('click', function (){
      lat.value = JSON.stringify(plopMarker.position.lat);
      lng.value = JSON.stringify(plopMarker.position.lng);
    });
};