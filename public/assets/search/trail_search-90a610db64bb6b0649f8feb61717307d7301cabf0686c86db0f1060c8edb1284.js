var trailSelect = function() {
    const select = document.getElementById('search_by')
    const dataList = document.getElementById('trails')

    select.addEventListener("change", trailSet)

    function trailSet() {
        if (select.value === 'by_trail') {
            autocomplete();
        }
    }

    function autocomplete() {
        document.getElementById('event_search').addEventListener("keyup", function() {
            let query = event.srcElement.value
            $.getJSON(`/api/trails/names?query=${query}`, clearAndPopulateList)
        })
    }

    function clearAndPopulateList(data) {
        dataList.innerHTML = ''
        $.each(data, function(key, value) {
            var option = document.createElement('option')
            option.value = value;
            dataList.appendChild(option)
        });
    }
}

trailSelect();
