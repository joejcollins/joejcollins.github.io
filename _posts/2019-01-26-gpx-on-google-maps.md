---
layout: post
---

Using QGIS version 3.4.3-Madeira.  A polygon can't be exported as GPX so it needs to be converted to a `track` to be exported.

* Select the boundary layer (left click)
* Edit > Select > Select Feature(s)
* Click on the polygon
* Vector > Geometry Tools > Polygons to Lines
    * Selected features only (ticked)
    * Run
    * Close
* Right click the new line layer
* Export > Save Features As...
    * File name `C:\whereever\the\project\is\boundary.gpx`
    * CRS `EPSG:4326 - WGS 84`
    * Add saved file to map (un ticked)
    * GPX_USE_EXTENSIONS `YES`
    * FORCE_GPX_TRACK `YES`

The resulting file should look like this.

```xml
{% include_relative gpx-on-google-maps/01-hyde-park.gpx %}
```

This GPX file can be shown on a Google Map like this.

```javascript
{% include_relative gpx-on-google-maps/02-gpx.js %}
```

Producing this map.

<div id="map" style="height:525px; width:525px;"></div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
{% include_relative gpx-on-google-maps/02-gpx.js %}
</script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCp-IYVkf_X8PnC304LOeYVfIyGtbIg7HM&callback=initMap"></script>
