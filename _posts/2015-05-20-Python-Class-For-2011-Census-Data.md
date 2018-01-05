---
layout: post
---

The ONS data.

```python
import ONS
census = ONS.Census("YOUR_API_KEY")
data = census.get_data("SW1A0AA", ONS.Data.religion, ONS.Area.Ward)
print(data)
```

This is the code.

```python
__author__ = 'Joe Collins'

#! /usr/bin/env python
# based on https://gist.github.com/sammachin/671f90c15ec6331598e5 and
# http://digitalpublishing.ons.gov.uk/2014/08/07/ons-api-just-the-numbers/

import xml.etree.ElementTree as ElementTree
import json
import requests


class Area:
    Ward = 14
    Authority = 13
    Region = 11


class Data:
    religion = "QS208EW"
    population = "QS102EW"
    social_grade = "QS611EW"
    qualifications = "QS501EW"
    ethnic_group = "QS201EW"
    economic_activity = "QS601EW"
    industry = "QS605EW"


class Census:

    def __init__(self, api_key):
        self.api_key = api_key

    @staticmethod
    def _get_area_id(self, level_type, postcode):
        """ Get the area id for the postcode
        :param level_type: The resolution you are interested in. 14 = ward level data.
        :param postcode: A UK postcode
        :return: string area identifier
        """
        base_url = "http://neighbourhood.statistics.gov.uk/NDE2/Disco/FindAreas"
        payload = {'HierarchyId': '27', 'Postcode': postcode}
        response = requests.get(base_url, params=payload)
        xml = ElementTree.fromstring(response.content)
        namespaces = {'ns1': 'http://neighbourhood.statistics.gov.uk/nde/v1-0/discoverystructs'}
        xpath_for_area = './/ns1:Area'
        areas = xml.findall(xpath_for_area, namespaces)
        ward_area_id = ''
        for area in areas:
            level_type_id = area.find('ns1:LevelTypeId', namespaces).text
            if level_type_id == str(level_type):  # find the Ward (=14)
                ward_area_id = area.find('ns1:AreaId', namespaces).text
        return ward_area_id

    @staticmethod
    def _get_ext_code(self, area_id):
        """ Get the ext code (whatever that is) from an area id
        :param area_id: the area id for a postcode
        :return: the ext code for an area (I think is the GSS code)
        """
        base_url = "http://neighbourhood.statistics.gov.uk/NDE2/Disco/GetAreaDetail"
        payload = {'AreaId': area_id}
        response = requests.get(base_url, params=payload)
        xml = ElementTree.fromstring(response.content)
        namespaces = {'ns1': 'http://neighbourhood.statistics.gov.uk/nde/v1-0/discoverystructs',
                      'structure': 'http://www.SDMX.org/resources/SDMXML/schemas/v2_0/structure'}
        xpath_for_ext_code = './/ns1:ExtCode'
        ext_code = xml.find(xpath_for_ext_code, namespaces).text
        return ext_code

    @staticmethod
    def _get_data(self, data_set, geog_code):
        """ Get the data for a geographical code
        :param API key from the ONS
        :param data_set: string identifier from http://www.nomisweb.co.uk/census/2011/quick_statistics
        :param geog_code: the ext code for the geographical area
        :return: a json object with the data
        """
        base_url = "http://data.ons.gov.uk/ons/api/data/dataset/" + data_set + ".json"
        payload = {'apikey': self.api_key, 'context': 'Census', 'geog': '2011WARDH', 'dm/2011WARDH': geog_code,
                   'totals': 'false', 'jsontype': 'json-stat'}
        response = requests.get(base_url, params=payload)
        obj = json.loads(response.text)
        return obj

    @staticmethod
    def _process(self, json_object, data_set):
        """
        :param json_object:
        :param data_set:
        :return:
        """
        data = {}
        values = json_object[data_set]['value']
        code_list_id = json_object[data_set]['dimension']['id'][1]
        index = json_object[data_set]['dimension'][code_list_id]['category']['index']
        labels = json_object[data_set]['dimension'][code_list_id]['category']['label']
        for label in labels:
            num = index[label]
            count = values[str(num)]
            data[labels[label]] = count
        return data

    @staticmethod
    def _process_population(self, json_object, data_set):
        """ The population data comes in separate segments so needs processing in a slightly different way
        :param json_object:
        :param data_set:
        :return:
        """
        data = {}
        keys = json_object.keys()
        segments = [k for k in keys if 'QS102EW Segment' in k]
        for segment in segments:
            code_list_id = json_object[segment]['dimension']['id'][1]
            label = json_object[segment]['dimension'][code_list_id]['label']
            data[label] = json_object[segment]['value']['0']
        return data

    def get_data(self, postcode, data_set, geographical_area):
        data = {}
        area_id = self._get_area_id(self, geographical_area, postcode)
        if area_id == "":  # The postcode isn't in England or Wales.
            return data
        gss_code = self._get_ext_code(self, area_id)
        data_returned = self._get_data(self, data_set, gss_code)
        if data_set == Data.population:  # Population has to be dealt with differently
            data = self._process_population(self, data_returned, gss_code)
        else:
            data = self._process(self, data_returned, data_set)
        return data
```
