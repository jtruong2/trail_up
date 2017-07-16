var dateSelect = function() {

    const select = document.getElementById('search_by')
    const inputField = document.getElementById('event_search')
    const form = document.querySelector('form')
    const submit = document.getElementById('submit')
    var endDate = document.createElement('input')
    endDate.setAttribute('type', 'date')
    endDate.setAttribute('name', 'end_date')
    endDate.setAttribute('id', 'end-date')

    select.addEventListener("change", function() {
        if (select.value === 'by_date') {
            inputField.setAttribute('type', 'date');
            form.insertBefore(endDate, submit)
        } else {
            inputField.setAttribute('type', 'text');
            var extra = document.getElementById('end-date')
            if (extra) {
                form.removeChild(extra)
            }
        }
    })
}