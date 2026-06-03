#!/bin/bash

cd tugasakhir

# Just run the JAR (build should happen during Railway build phase)
if [ -f "target"/*.jar ]; then
  java -Dfile.encoding=UTF-8 -jar target/*.jar
else
  echo "JAR file not found in target/"
  exit 1
fi
