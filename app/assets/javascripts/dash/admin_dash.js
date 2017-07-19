var displayToggles = function() {

    $('#admin-trails-btn').on('click', function() {
        $(this).toggleClass('active-button');
        $('.admin-trails').toggle('hidden');
    })
    $('#admin-users-btn').on('click', function() {
        $(this).toggleClass('active-button');
        $('.admin-users').toggle('hidden')
    })
    $('#admin-events-btn').on('click', function() {
        $(this).toggleClass('active-button');
        $('.admin-events').toggle('hidden')
    })

}

displayToggles();