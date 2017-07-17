var dateSelect = function() {

    const select = document.getElementById('search_by')
    const inputField = document.getElementById('event_search')
    const submit = document.getElementById('submit')
    const form = document.querySelector('form')
    const endDate = document.createElement('input')

    setAttributes(endDate, {
        "type": "date",
        "name": "end_date",
        "id": "end-date"
    })

    select.addEventListener("change", changeInputFields)

    function changeInputFields() {
        if (select.value === 'by_date') {
            inputField.setAttribute('type', 'date');
            form.insertBefore(endDate, submit)
        } else {
            inputField.setAttribute('type', 'text');
            removeField(form, 'end-date')
        }
    }
}

function setAttributes(el, attrs) {
    for (var key in attrs) {
        el.setAttribute(key, attrs[key]);
    }
}

function removeField(parent, fieldId) {
    let field = document.getElementById(fieldId)
    if (field) {
        parent.removeChild(field)
    }
}