// add listener to upcoming
var filterCategory = "upcoming";

var filterEvents = function() {

    var hideFilteredElements = function(element) {
        if (!element.classList.value.includes(filterCategory)) {
            element.style.display = "none";
        }
        if (element.classList.value.includes(filterCategory) && element.style.display == "none") {
            element.style.display = "";
        }
    }

    var domTraversal = function(events) {
        Array.prototype.forEach.call(events, function(element, index) {
            hideFilteredElements(element)
        });
    }

    var events = document.getElementsByClassName('event');
    domTraversal(events);


    var attending = document.getElementById("attending");
    attending.addEventListener("click", function() {
        window.filterCategory = "upcoming guest";
        domTraversal(events);
    });

    var hosting = document.getElementById("hosting");
    hosting.addEventListener("click", function() {
        window.filterCategory = "upcoming host";
        domTraversal(events);
    });

    var upcoming = document.getElementById("upcoming");
    upcoming.addEventListener("click", function() {
        window.filterCategory = "upcoming";
        domTraversal(events);
    });

    var past = document.getElementById("past");
    past.addEventListener("click", function() {
        window.filterCategory = "past";
        domTraversal(events);
    });
}
filterEvents();