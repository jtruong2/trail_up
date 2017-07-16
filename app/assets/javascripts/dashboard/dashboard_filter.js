// add listener to upcoming
var filter_category = "upcoming";

var filter_events = function() {

  var events = document.getElementsByClassName('event')

  var hide_filtered_elements = function(element) {
    if (!element.classList.contains(filter_category)) {
      element.style.display='none';
    }
  }

  Array.prototype.forEach.call(events, function(element, index) {
    hide_filtered_elements(element)
  });


}

// document.querySelectorall('events')
