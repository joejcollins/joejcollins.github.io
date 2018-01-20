---
layout: post
---

Python Class

```python
"""Module for getting data from the Google APIs.

A public API access key is required from https://console.developers.google.com/.
The key is specific to a project and is set to allow for server applications from
specific IP addresses.

"""

import urllib
import requests

class Maps:

    base_url = u"https://maps.googleapis.com/maps/api/"

    def __init__(self, api_key):
        self.api_key = api_key

    def get_data(self, name, postcode):
        """ Get a data set describing a Google place

        :param name: name of the location (typically the venue name.
        :param postcode: UK postcode for the venue
        :return: data set as dict
        """
        data = self._geocode(name, postcode)
        data = self._place(data)
        return data

    def _geocode(self, name, postcode):
        """ Geocode the location

        :param name: name of the location (typically the venue name).
        :param postcode: UK postcode for the venue
        :return: data set as dict containing the latitude, longitude and Google place id
        """
        postcode = postcode.replace(" ", "")  # Remove the spaces from the Postcode
        postcode = postcode.upper()
        address = name + "," + postcode + ",UK"
        address = urllib.quote_plus(address)

        url = self.base_url + "geocode/json?address=%s" % address
        response = requests.get(url)
        json_geocode = response.json()
        data = {}
        if json_geocode["status"] == "OK":
            geocode_result = json_geocode["results"][0]
            location = geocode_result["geometry"]["location"]
            data["Latitude"] = location["lat"]
            data["Longitude"] = location["lng"]
            data["GooglePlaceId"] = geocode_result["place_id"]
        return data

    def _place(self, data):
        """ Add Google place information the the data set

        :param data: Dict containing a Google place id with key "GooglePlaceId".
        :return: expanded dataset with the Google place information added.
        """
        url = self.base_url + "place/details/json"
        payload = {'key': self.api_key, 'placeid': data["GooglePlaceId"]}
        response = requests.get(url, params=payload)
        json_place = response.json()
        if json_place["status"] == "OK":
            place_result = json_place["result"]
            if 'rating' in place_result:
                rating = place_result["rating"]
                data["GoogleRating"] = rating
            else:
                data["GoogleRating"] = 'NULL'
        return data
```