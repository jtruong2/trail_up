var dateSelect = function() {

    const select = document.getElementById('search_by')
    const inputField = document.getElementById('event_search')
    const submit = document.getElementById('submit')
    const form = document.querySelector('form')
    const endDate = document.createElement('input')
    const endDateLabel = document.createElement('label')
    endDateLabel.innerText = "End Date"
    const tag = document.querySelector('.location')

    setAttributes(endDateLabel, {
        "id": "end_date_label",
    })
    setAttributes(endDate, {
        "type": "date",
        "name": "end_date",
        "id": "end-date"
    })

    select.addEventListener("change", changeInputFields)

    function changeInputFields() {
        if (select.value === 'by_date') {
            tag.innerText = "Start Date"
            inputField.setAttribute('type', 'date');
            form.insertBefore(endDate, submit)
            form.insertBefore(endDateLabel, endDate)
        } else if (select.value === 'by_name') {
            setAttributes(inputField, { "type": "text", "placeholder": "event name..." });
            tag.innerText = "Event Name"
            inputField.setAttribute('type', 'text');
            removeField(form, 'end-date')
            removeField(form, 'end_date_label')
        } else if (select.value === 'by_trail') {
            setAttributes(inputField, { "type": "text", "placeholder": "trail name..." });
            tag.innerText = "Trail Name"
            removeField(form, 'end-date')
            removeField(form, 'end_date_label')
        } else if (select.value === 'by_location') {
            setAttributes(inputField, { "type": "text", "placeholder": "location..." });
            tag.innerText = "Location"
            removeField(form, 'end-date')
            removeField(form, 'end_date_label')

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