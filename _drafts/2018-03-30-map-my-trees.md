---
layout: post
---

*Abundance distributions for tree species in Great Britain: a two-stage approach to modeling abundance using species distribution modeling and Random Forest* <https://onlinelibrary.wiley.com/doi/10.1002/ece3.2661> (2016) provides predicted abundance map rasters at <https://sylva.org.uk/forestryhorizons/documents/Predicted%20abundance%20map%20rasters.zip>.  These are relatively easy to use in QGIS.

    Layer > Add Layer > Add Raster Layer...

But less straight forward to display on Google Maps.

<http://zevross.com/blog/2015/08/21/process-a-raster-for-use-in-a-google-map-using-r/>

<https://www.datacamp.com/courses/spatial-analysis-in-r-with-sf-and-raster>

<div id="map" style="height:525px; width:525px;"></div>

<script>
var treeOverlay;

function initMap() {
    var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 7,
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

</script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCp-IYVkf_X8PnC304LOeYVfIyGtbIg7HM&callback=initMap"></script>
