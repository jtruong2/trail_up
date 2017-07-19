var filterCategories = ["upcoming"];

var filterEvents = function() {

    var hideFilteredElements = function(element) {
      Array.prototype.forEach.call(window.filterCategories, function(filter, index) {
        if (!element.classList.value.includes(filter)) {
            element.style.display = "none";
        }
        if (element.classList.value.includes(filter) && element.style.display == "none") {
            element.style.display = "";
        }
      }
      )
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
      if (this.classList.value.includes('selected')) {
        index = window.filterCategories.indexOf("guest");
        window.filterCategories.splice(index, 1);
      } else {
        window.filterCategories.push("guest");
      }
      if ($("#hosting").hasClass("selected")) {
        $("#hosting").toggleClass("selected")
      }
      $("#attending").toggleClass('selected');
      domTraversal(events);
    });

    var hosting = document.getElementById("hosting");
    hosting.addEventListener("click", function() {
      if (this.classList.value.includes('selected')) {
        index = window.filterCategories.indexOf("guest");
        window.filterCategories.splice(index, 1);
      } else {
        window.filterCategories.push("host");
      }
      if ($("#attending").hasClass("selected")) {
        $("#attending").toggleClass("selected")
      }
      $("#hosting").toggleClass('selected');
      domTraversal(events);
    });
}
filterEvents();
