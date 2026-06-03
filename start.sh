#!/bin/bash

cd tugasakhir

# Install dependencies
mvn clean install -DskipTests -q

# Run application
java -jar target/*.jar
