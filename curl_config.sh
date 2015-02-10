#!/bin/sh

grep porxy ~/.curlrc
if [ $? -ne 0 ] ; then
  echo "proxy = $http_proxy" >> ~/.curlrc
fi

grep noproxy ~/.curlrc
if [ $? -ne 0 ] ; then
  echo "noproxy = $no_proxy" >> ~/.curlrc
fi

