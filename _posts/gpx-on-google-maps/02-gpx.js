function initMap() {
    var spainsHall = new google.maps.LatLng(51.505164646, -0.158166034);
    var mapOptions = {
        center: spainsHall,
        zoom: 10,
        mapTypeId: google.maps.MapTypeId.SATELLITE
    };
    var map = new google.maps.Map(document.getElementById('map'), mapOptions);
    $.ajax({
        type: "GET",
        url: "https://raw.githubusercontent.com/joejcollins/atlanta-shore/master/data/raw/outer_fence.gpx",
        dataType: "xml",
        success: function (xml) {
            var points = [];
            var bounds = new google.maps.LatLngBounds();
            $(xml).find("trkpt").each(function () {
                    var lat = $(this).attr("lat");
                    var lon = $(this).attr("lon");
                    var p = new google.maps.LatLng(lat, lon);
                    points.push(p);
                    bounds.extend(p);
            });
            var poly = new google.maps.Polyline({
                    path: points,
                    strokeColor: "#FF00AA",
                    strokeOpacity: .7,
                    strokeWeight: 4
            });
            poly.setMap(map);
            map.fitBounds(bounds);
        }
    });
}