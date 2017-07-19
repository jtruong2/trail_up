var displayToggles = function() {

    $('#admin-trails-btn').on('click', function() {
        $(this).toggleClass('active-button');
        $(this).siblings().removeClass('active-button')
        $('.admin-trails').removeClass('hidden');
        hideOthers($('.admin-trails').siblings());
    })
    $('#admin-users-btn').on('click', function() {
        $(this).toggleClass('active-button');
        $(this).siblings().removeClass('active-button')
        $('.admin-users').removeClass('hidden');
        hideOthers($('.admin-users').siblings());
    })
    $('#admin-events-btn').on('click', function() {
        $(this).toggleClass('active-button');
        $(this).siblings().removeClass('active-button')
        $('.admin-events').removeClass('hidden');
        hideOthers($('.admin-events').siblings());
    })

}

const hideOthers = function(node) {
    node.each(function() {
        if (this.classList.contains('hidden')) {

        } else {
            this.classList.add('hidden')
        }
    })
}

displayToggles();