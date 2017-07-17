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
        } else if (select.value === 'by_name') {
            setAttributes(inputField, { "type": "text", "placeholder": "event name..." });
            inputField.setAttribute('type', 'text');
            removeField(form, 'end-date')
        } else if (select.value === 'by_trail') {
            setAttributes(inputField, { "type": "text", "placeholder": "trail name..." });
            removeField(form, 'end-date')
        } else if (select.value === 'by_location') {
            setAttributes(inputField, { "type": "text", "placeholder": "location..." });
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