---
layout: post
---

How many times did I visit Shrewsbury?  Or at least how many times did my telephone visit Shrewsbury?

This is based on this strategy &lt;https: 12="" 2016="" 30="" maps="" shiring.github.io="" standortverlauf_post=""&gt; for querying the location data.

Google Take Out &lt;https: settings="" takeout="" takeout.google.com=""&gt; provides my location data in Json format, with `jsonlite` will load.  The `Location History.json` is already stripped down to 7 days, so there is less of it to handle.  The whole file is pretty big so is difficult to work with on Azure Notebooks.&lt;/https:&gt;&lt;/https:&gt;


```R
# Load the package
library(jsonlite)
system.time(import <- fromJSON("Location History.json"))
```


       user  system elapsed 
      0.882   0.011   1.286 



```R
# extracting the locations dataframe
locations = import$locations
head(locations[,c("latitudeE7", "longitudeE7", "timestampMs")], n=3)
```


<table>
<thead><tr><th>latitudeE7</th><th>longitudeE7</th><th>timestampMs</th></tr></thead>
<tbody>
	<tr><td>525622196    </td><td>-27951121    </td><td>1541616455811</td></tr>
	<tr><td>525622196    </td><td>-27951121    </td><td>1541616049051</td></tr>
	<tr><td>525622196    </td><td>-27951121    </td><td>1541615881157</td></tr>
</tbody>
</table>



## Converting the Data

The dates are held as POSIX dates (milliseconds since the begining of time) and need to be converted to to queried in a readable manner.  Also the locations are held as integers (for convenience) so need to be divided by 10^7 to get the latitude and longitudes.  The 'E7' on the field implies this.


```R
# converting time column from posix milliseconds into a readable time scale
locations$date_time = as.POSIXct(as.numeric(locations$timestampMs)/1000, origin = "1970-01-01")
locations$date <- as.Date(locations$date_time)
# converting longitude and latitude from E7 to GPS coordinates
locations$lat = locations$latitudeE7 / 1e7
locations$lon = locations$longitudeE7 / 1e7

# To get the days of the week so I can query for thing 'weekend' install and load the package `lubridate`
install.packages("lubridate")
library(lubridate)

locations$weekday <- wday(as.Date(locations$date_time))
head(locations[,c("lat", "lon", "date", "weekday")], n=3)

```

    Installing package into ‘/home/nbuser/R’
    (as ‘lib’ is unspecified)
    Warning message in install.packages("lubridate"):
    “installation of package ‘lubridate’ had non-zero exit status”
    Attaching package: ‘lubridate’
    
    The following object is masked from ‘package:base’:
    
        date
    



<table>
<thead><tr><th>lat</th><th>lon</th><th>date</th><th>weekday</th></tr></thead>
<tbody>
	<tr><td>52.56222  </td><td>-2.795112 </td><td>2018-11-07</td><td>4         </td></tr>
	<tr><td>52.56222  </td><td>-2.795112 </td><td>2018-11-07</td><td>4         </td></tr>
	<tr><td>52.56222  </td><td>-2.795112 </td><td>2018-11-07</td><td>4         </td></tr>
</tbody>
</table>



## Select the Visits

Using a box around Shrewsbury where:

* bottom left = 52.704117, -2.762084
* top right = 52.709638, -2.748738 

And selecting the where the weekday is between 2 and 6 (Sunday = 1 and Saturday = 7, don't ask me why).


```R
locations_in_shrewsbury <- subset(locations, lat > 52.704117 & lat < 52.709638 & lon< -2.748738 & lon> -2.762084 & weekday > 1 & weekday < 7)
visits_to_shrewsbury_in_working_week <- unique(locations_in_shrewsbury[c("date","weekday")])
head(visits_to_shrewsbury_in_working_week, n=10)
```


<table>
<thead><tr><th></th><th>date</th><th>weekday</th></tr></thead>
<tbody>
	<tr><th>66</th><td>2018-11-07</td><td>4         </td></tr>
	<tr><th>451</th><td>2018-11-06</td><td>3         </td></tr>
	<tr><th>983</th><td>2018-11-02</td><td>6         </td></tr>
</tbody>
</table>



Giving 3 visits to Shrewsbury in those 7 days.
