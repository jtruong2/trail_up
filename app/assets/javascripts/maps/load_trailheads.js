

$(document).ready(function() {

  var trailheads = $.getJSON('api/all_trails', data, function(data) {

  })
});

get

    // var trailheads = for(i = 0; i < data.length; i ++) {
    //   $('#display-data').append(data[i].name )
    // };

// var trailheads;
//
// $(document).ready(function() {
//   $.getJSON('api/all_trails', function(json){
//     trailheads = json;
//   })
//
//   debugger
//   for(i = 0; i < trailheads.length; i ++) {
//     $('#display-data').append(trailheads[i].name )
//   }
// });