#!/bin/bash
while true;
do
  curl -s http://$1;
  echo "";
  sleep 0.5;
done
