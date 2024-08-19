#!/bin/bash

cd ../certs
openssl req -x509 -newkey rsa:4096 -keyout serverkey.pem -out servercert.pem -nodes -days 3970
