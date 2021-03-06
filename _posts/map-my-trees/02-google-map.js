var treeOverlay;
function initMap() {
    var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 6,
    center: {lat: 52.489471, lng: -1.898575},
    mapTypeId: google.maps.MapTypeId.TERRAIN
    });
    var bounds = {
        north: 58.7527,
        south: 49.83462,
        east: 2.470118,
        west: -7.940282
    };
    var options = {
        opacity:0.5
    }
    var image = '{{ site.url }}/assets/tree-map.png'
    treeOverlay = new google.maps.GroundOverlay(image, bounds, options);
    treeOverlay.setMap(map);
}