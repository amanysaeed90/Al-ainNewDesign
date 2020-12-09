
function init() {
    var imgDefer = document.getElementsByTagName('img');
    for (var i=0; i<imgDefer.length; i++) {
        imgDefer[i].style.backgroundColor = '#d0d0d0'
        if(imgDefer[i].getAttribute('data-src')) {
            imgDefer[i].setAttribute('src',imgDefer[i].getAttribute('data-src'));
            
        } }
}



function addClickListiner() {
    var imgDefer = document.getElementsByTagName('img');
    for (var i=0; i<imgDefer.length; i++) {
            imgDefer[i].onclick = function(event) {
                window.location.href = this.src + '_img';
            };
    }
}




setTimeout(init, 3000);
setTimeout(addClickListiner, 6000);
