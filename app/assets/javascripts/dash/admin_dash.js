var displayToggles = function() {

    $('#admin-trails-btn').on('click', function() {
        $(this).toggleClass('active-button');
        $('.admin-trails').toggle('hidden');
        // $('.admin-trails').toggle('top-div');
        // $('.admin-users').toggle('top-div');
        // $('.admin-events').toggle('top-div');
    })
    $('#admin-users-btn').on('click', function() {
        $(this).toggleClass('active-button');
        $('.admin-users').toggle('hidden');
        // $('.admin-users').toggle('top-div');
        // $('.admin-trails').toggle('top-div');
        // $('.admin-events').toggle('top-div');
    })
    $('#admin-events-btn').on('click', function() {
        $(this).toggleClass('active-button');
        $('.admin-events').toggle('hidden');
        // $('.admin-events').toggle('top-div');
        // $('.admin-trails').toggle('top-div');
        // $('.admin-users').toggle('top-div');
    })

}

displayToggles();