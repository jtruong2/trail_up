var dateSelect = function() {

    select = document.getElementById('search_by')
    inputField = document.getElementById('event_search')
    select.addEventListener("change", function() {
        if (select.value === 'by_date') {
            inputField.setAttribute('type', 'date');
        } else {
            inputField.setAttribute('type', 'text');
        }
    })
}