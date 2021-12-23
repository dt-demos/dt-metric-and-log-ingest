# Overview

Simple node app that will log messages to a file.  Tested with Node v14.18.2

# Run Locally

```
node logapp.js
```

# Build

Use `buildpush.sh` script

# Run Docker

```
docker run -it -e LOOPS=10 -e LOGFILE=/mount/applog.log -v $(pwd):/mount dtdemos/logapp:1.0.0 
```
