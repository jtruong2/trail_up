var dateSelect = function() {

    const select = document.getElementById('search_by')
    const inputField = document.getElementById('event_search')
    select.addEventListener("change", function() {
        if (select.value === 'by_date') {
            inputField.setAttribute('type', 'date');
        } else {
            inputField.setAttribute('type', 'text');
        }
    })
}