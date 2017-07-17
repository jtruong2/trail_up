// add listener to upcoming
var filter_category = "upcoming";
var background_selection = "#BF392e";

var filter_events = function() {

  var hide_filtered_elements = function(element) {
    if (!element.classList.value.includes(filter_category)) {
      element.style.display = "none";
    }
    if (element.classList.value.includes(filter_category) && element.style.display == "none") {
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
    window.filter_category = "upcoming guest";
    dom_traversal(events);
    attending.style.backgroundColor = window.background_selection;
  });

  var hosting = document.getElementById("hosting");
  hosting.addEventListener("click", function() {
    window.filter_category = "upcoming host";
    dom_traversal(events);
  });

  var upcoming = document.getElementById("upcoming");
  upcoming.addEventListener("click", function() {
    window.filter_category = "upcoming";
    dom_traversal(events);
  });

  var past = document.getElementById("past");
  past.addEventListener("click", function() {
    window.filter_category = "past";
    dom_traversal(events);
  });
}
