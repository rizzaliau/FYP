var feedback = function(res) {
    if (res.success === true) {
        var get_link = res.data.link.replace(/^http:\/\//i, 'https://');
        document.querySelector('.status').classList.add('bg-success');
        document.querySelector('.status').innerHTML =
            'Image URL: ' + '<br><input class="image-url" value=\"' + get_link + '\"/>' ;
        document.getElementById('outputURL').innerHTML = get_link;
    }
};

new Imgur({
    clientid: '4fab46f5c3b7a9a', //You can change this ClientID
    callback: feedback
});