---
layout: post
title: Misleading
---

joejcollins:~/workspace (master) $ git checkout .
joejcollins:~/workspace (master) $ python ../google-cloud-sdk/platform/google_appengine/dev_appserver.py ./web_app/ --host=0.0.0.0 
INFO     2017-06-30 12:39:02,489 sdk_update_checker.py:231] Checking for updates to the SDK.
INFO     2017-06-30 12:39:03,029 api_server.py:312] Starting API server at: http://localhost:40063
WARNING  2017-06-30 12:39:03,030 dispatcher.py:287] Your python27 micro version is below 2.7.12, our current production version.
INFO     2017-06-30 12:39:03,040 dispatcher.py:226] Starting module "default" running at: http://0.0.0.0:8080
INFO     2017-06-30 12:39:03,041 admin_server.py:116] Starting admin server at: http://localhost:8000
ERROR    2017-06-30 12:39:07,170 wsgi.py:263] 
Traceback (most recent call last):
  File "/home/ubuntu/google-cloud-sdk/platform/google_appengine/google/appengine/runtime/wsgi.py", line 240, in Handle
    handler = _config_handle.add_wsgi_middleware(self._LoadHandler())
  File "/home/ubuntu/google-cloud-sdk/platform/google_appengine/google/appengine/runtime/wsgi.py", line 299, in _LoadHandler
    handler, path, err = LoadObject(self._handler)
  File "/home/ubuntu/google-cloud-sdk/platform/google_appengine/google/appengine/runtime/wsgi.py", line 85, in LoadObject
    obj = __import__(path[0])
  File "/home/ubuntu/workspace/web_app/main.py", line 4, in <module>
    from flask import Flask
ImportError: No module named flask
INFO     2017-06-30 12:39:07,175 module.py:832] default: "GET / HTTP/1.1" 500 -

