const swiper = function() {
    const bg = document.querySelector('.jumbotron')
    window.setInterval(swipe, 10000);

    function swipe() {
        switch (bg.classList[1]) {
            case "bga":
                bg.classList.remove('bga')
                bg.classList.add('bgb')
                break;
            case "bgb":
                bg.classList.remove('bgb')
                bg.classList.add('bgc')
                break;
            case "bgc":
                bg.classList.remove('bgc')
                bg.classList.add('bga')
                break;
        }

    }

}