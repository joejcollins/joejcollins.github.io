

<http://zevross.com/blog/2015/08/21/process-a-raster-for-use-in-a-google-map-using-r/>

<div id="map"></div>

<script>
var treeOverlay;

function initMap() {
    var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 4,
    center: {lat: 52.489471, lng: ‎-1.898575},
    mapTypeId: google.maps.MapTypeId.TERRAIN
    });

    var bounds = {
        north: 58.7527,
        south: 49.83462,
        east: 2.470118,
        west: -7.940282
    };

    var overlayOpts = {
        opacity:0.5
    }

    var imgSrc = '{{ site.url }}assets/tree-map.png'

    treeOverlay = new google.maps.GroundOverlay(imgSrc, bounds, overlayOpts);
    treeOverlay.setMap(map);
}

</script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBUWJlzi5DB9NpE3r5XhwHSuIdqvrAoC9w&callback=initMap"></script>
