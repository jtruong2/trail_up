var trailSelect = function() {
    const select = document.getElementById('search_by')
    var dataList = document.getElementById('trails')
    select.addEventListener("change", function() {
        if (select.value === 'by_trail_name') {
            document.getElementById('event_search').addEventListener("keyup", function() {
                var query = event.srcElement.value
                $.getJSON(`/api/trails?query=${query}`, function(data) {
                    dataList.innerHTML = ''
                    $.each(data, function(key, value) {
                        var option = document.createElement('option')
                        option.value = value;
                        dataList.appendChild(option)
                    });
                })
            })
        }
    })
}