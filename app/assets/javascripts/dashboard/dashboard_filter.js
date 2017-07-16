// add listener to upcoming
var filter_category = "upcoming-host";

var filter_events = function() {

  var hide_filtered_elements = function(element) {
    if (!element.classList.contains(filter_category)) {
      element.style.display = "none";
    }
    if (element.classList.contains(filter_category) && element.style.display == "none") {
      element.style.display = "";
    }
  }

  var dom_traversal = function(events) {
    Array.prototype.forEach.call(events, function(element, index) {
      hide_filtered_elements(element)
    });
  }

  var events = document.getElementsByClassName('event');
  dom_traversal(events);

  var attending = document.getElementById("attending");
  attending.addEventListener("click", function() {
    window.filter_category = "upcoming-guest";
    dom_traversal(events);
  });
}
