---
layout: post
---

Can't be bothered to think of a commit message?  Then put in the weather and the news.

```python
# -*- coding: utf-8 -*-
"""Git, Add, Commit and Push in one go

If you want to add, commit and push in one go, then you are not using Git correctly.
But then again you might not care that much.

Requires
    pip install GitPython
	pip install beautifulsoup4
	pip install requests

"""
__author__ = "Joe Collins"

import os
from bs4 import BeautifulSoup
import requests
import git

# Key from https://developer.forecast.io/
KEY = "c80e6671f5b931130a2537caee64d3e6"

# Longitude and latitude for Bagbatch
LAT = "52.5636057"
LNG = "-2.8060048"

def get_weather_right_now(lat, lng):
    ''' Return a summary of the weather for a location '''
    url = 'https://api.forecast.io/forecast/' + \
        KEY + '/' + \
        lat + ',' + \
        lng + '?units=si&exclude=minutely,hourly,daily,alerts,flags' # exclude a lot for
    response = requests.get(url)
    try:
        weather_right_now = response.json()['currently']
    except ValueError as error:
        if str(error) != 'No JSON object could be decoded':
            raise
        else:
            return 'Dunno what the weather is, no JSON came back'
    summary = weather_right_now['summary']
    temperature = weather_right_now['temperature']
    return '{}, {}C'.format(summary, temperature)

def get_headline():
    ''' Return the lastest BBC headline'''
    url = 'http://feeds.bbci.co.uk/news/rss.xml'
    response = requests.get(url)
    rss = response.content
    page = BeautifulSoup(rss, 'html.parser')
    first_story_title = page.findAll('title')[2].contents[0] # the 3rd title is the first story
    return '{:.45}'.format(first_story_title) # precision = number of characters after decimal point

WEATHER = get_weather_right_now(LAT, LNG)
HEADLINE = get_headline()
MESSAGE = 'Weather: {}, BBC News: {}, '.format(WEATHER, HEADLINE)

REPO = git.Repo(os.getcwd() + "/.git")
GIT = REPO.git
GIT.add('.')
print GIT.commit('-m', MESSAGE)
GIT.push()
```
