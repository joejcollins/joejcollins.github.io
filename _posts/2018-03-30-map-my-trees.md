

<http://zevross.com/blog/2015/08/21/process-a-raster-for-use-in-a-google-map-using-r/>



<div id="map"></div>

<script>
var landuseOverlay;

function initMap() {
    var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 4,
    center: {lat: 65, lng: -152.2683},
    mapTypeId: google.maps.MapTypeId.TERRAIN
});

var bounds = new google.maps.LatLngBounds(
    new google.maps.LatLng(54.36582, -167.7103),
    new google.maps.LatLng(71.39622, -129.9973));

var overlayOpts = {
    opacity:0.5
}

var imgSrc = '{{ site.url }}/assets/tree-map.png'

landuseOverlay = new google.maps.GroundOverlay(imgSrc, bounds, overlayOpts);
landuseOverlay.setMap(map);
}

</script>
<script async="" defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBUWJlzi5DB9NpE3r5XhwHSuIdqvrAoC9w&callback=initMap"></script>
