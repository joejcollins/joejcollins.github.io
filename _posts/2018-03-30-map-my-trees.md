---
layout: post
---

"Abundance distributions for tree species in Great Britain: a two-stage approach to modeling abundance using species distribution modeling and Random Forest" <https://onlinelibrary.wiley.com/doi/10.1002/ece3.2661> (2016) provides predicted abundance map rasters at <https://sylva.org.uk/forestryhorizons/documents/Predicted%20abundance%20map%20rasters.zip>.  These are relatively easy to use in QGIS.

    Layer > Add Layer > Add Raster Layer...

![QGIS Tree Map]({{ site.url }}/assets/qgis.png)

But less straight forward to display on Google Maps.  Fortunately, Hollie Olmstead has done the hard work and demonstrates a solution <http://zevross.com/blog/2015/08/21/process-a-raster-for-use-in-a-google-map-using-r/> using R.  This is hardly surprising since if you look a the `.grd` files they were originally created with R package 'raster'.  The `.grd` header file comes with and associated `.gri` binary data file of the same name.

```
{% include_relative map-my-trees/acer-campestre.grd %}
```

The approach is to transform the raster using a coordinate reference system appropriate to Google Maps and then produce a deformed image to suit.  Hollie Olmstead tries a number of different approaches.  This seems the least obvious, but generates the best result.

```R
{% include_relative map-my-trees/01-transform.r %}
```
Now a the image can be used in a Google Map overlay.

```javascript
{% include_relative map-my-trees/02-google-map.js %}
```

Producing this map.

<div id="map" style="height:525px; width:525px;"></div>
<script>
{% include_relative map-my-trees/02-google-map.js %}
</script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCp-IYVkf_X8PnC304LOeYVfIyGtbIg7HM&callback=initMap"></script>


