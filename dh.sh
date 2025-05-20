#!/usr/bin/env bash

experiment="dh"

mkdir -p "$experiment"

openssl genpkey -genparam -algorithm DH -out "$experiment/dhparams.pem"

openssl genpkey -paramfile "$experiment/dhparams.pem" -out "$experiment/joe_key.pem"
openssl pkey -in "$experiment/joe_key.pem" -pubout -out "$experiment/joe_pub.pem"

openssl genpkey -paramfile "$experiment/dhparams.pem" -out "$experiment/bea_key.pem"
openssl pkey -in "$experiment/bea_key.pem" -pubout -out "$experiment/bea_pub.pem"

openssl pkeyutl -derive -inkey "$experiment/joe_key.pem" -peerkey "$experiment/bea_pub.pem" | base64 > "$experiment/joe_secret.txt"
openssl pkeyutl -derive -inkey "$experiment/bea_key.pem" -peerkey "$experiment/joe_pub.pem" | base64 > "$experiment/bea_secret.txt"
