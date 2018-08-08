var feedback = function(res) {
    if (res.success === true) {
        var get_link = res.data.link.replace(/^http:\/\//i, 'https://');
        document.querySelector('.status').classList.add('bg-success');
        document.querySelector('.status').innerHTML =
            'Image Uploaded Successfully! ' + '<br><input type="hidden" value=\"' + get_link + '\"/ name="newImageURL" >' ;
        document.getElementById('outputURL').innerHTML = get_link;
    }
};

new Imgur({
    clientid: '4fab46f5c3b7a9a', //You can change this ClientID
    callback: feedback
});