---
layout: post
---

Data was originally downloaded from <https://registry.nbnatlas.org/public/showDataResource/dr782>.  In my experience this wasn't a very reliable process, I have tried this several times but have only been able to get it to work once.

    From: data@nbnatlas.org
    To: joejcollins@gmail.com
    Subject: NBN Atlas Occurrence Download Failed - records-2019-10-23
    Date: Wed, 23 Oct 2019 14:00:01 +0000 (UTC)
    The download has failed.
    uniqueId:64586eb8-591d-3a71-9913-2c9bba1b9c5d-1571838857002 path:/64586eb8-591d-3a71-9913-2c9bba1b9c5d/1571838857002/records-2019-10-23.zip

Link to the data file so it isn't included in the repository since it is 364 MB

    mklink records-2018-11-22.csv "C:\Users\username\path\to\the\file\records-2018-11-22.csv"


```python
import pandas as pd
sedn20181122 = pd.read_csv("records-2018-11-22.csv",  engine='c')
# Clean up the column names
sedn20181122.columns = sedn20181122.columns.str.strip().str.lower().str.replace(' ', '_').str.replace('(', '').str.replace(')', '')
sedn20181122.shape
```

    C:\Users\joejc\envs\professor-matic\lib\site-packages\IPython\core\interactiveshell.py:3058: DtypeWarning: Columns (9,25,29,30,31) have mixed types. Specify dtype option on import or set low_memory=False.
      interactivity=interactivity, compiler=compiler, result=result)

    (651411, 53)

It would be useful to take a look at the localities to see if they are the sites names that people are used to.

```python
localities = sedn20181122.locality.unique()
display(len(localities))
localities[:10] # to look at the first 10
```
    5300

    array(['Lower House, Llanymynech', nan, 'Bitterley Court', 'Cleestanton',
           'Cambrian Heritage Railway, Porth-y-waen', 'Spurtree',
           'Oswestry Railway Station', 'Easthope Pools', 'Graig Farm',
           'Loamhole Dingle'], dtype=object)

Not all the taxa are species.

```python
taxa = sedn20181122.taxon_rank.unique()
taxa
```
    array(['species', 'unranked', 'genus', 'subspecies', 'variety',
           'cultivar', 'phylum', 'species group', 'order', 'family'],
          dtype=object)

