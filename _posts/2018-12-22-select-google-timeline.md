---
layout: post
---

Load up the file from Google Take Out <https://takeout.google.com/settings/takeout>.


```python
import json
import time
import dateutil.parser

with open('Location History.json', 'r') as f:
    LOCATION_HISTORY = json.load(f)
```

I like ISO 8601 dates because they are easier to read, so that's how the 8 hours on 3rd November are expressed.


```python
START = "2018-11-03T07:00:00Z"
END = "2018-11-03T19:00:00Z"

start = dateutil.parser.parse(START)
end = dateutil.parser.parse(END)

start_posix = time.mktime(start.timetuple())
end_posix = time.mktime(end.timetuple())
```

Build up a list comprehension like this, starting with just the list.

```
[LOCATION_HISTORY['locations']]
[location for location in LOCATION_HISTORY['locations']]
[location for location in LOCATION_HISTORY['locations'] if location['timestampMs'] == '1545539869054']
```


```python
NOVEMBER_LOCATIONS = [location for location in LOCATION_HISTORY['locations'] 
                      if location['timestampMs'] <= str(end_posix)
                      and location['timestampMs'] >= str(start_posix)]

with open('Selected Location History.json', 'w') as outfile:
    json.dump({'locations': NOVEMBER_LOCATIONS}, outfile, indent=4, sort_keys=True)
```
