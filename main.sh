#!/usr/bin/env bash

experiment="experiment"

mkdir -p "$experiment"

openssl genpkey -genparam -algorithm EC -out "$experiment/ecdhparams.pem" \
  -pkeyopt ec_paramgen_curve:P-384 \
  -pkeyopt ec_param_enc:named_curve

openssl genpkey -paramfile "$experiment/ecdhparams.pem" -out "$experiment/joe_key.pem"
openssl pkey -in "$experiment/joe_key.pem" -pubout -out "$experiment/joe_pub.pem"

openssl genpkey -paramfile "$experiment/ecdhparams.pem" -out "$experiment/bea_key.pem"
openssl pkey -in "$experiment/bea_key.pem" -pubout -out "$experiment/bea_pub.pem"

openssl pkeyutl -derive -inkey "$experiment/joe_key.pem" -peerkey "$experiment/bea_pub.pem" | base64 > "$experiment/joe_secret.txt"
openssl pkeyutl -derive -inkey "$experiment/bea_key.pem" -peerkey "$experiment/joe_pub.pem" | base64 > "$experiment/bea_secret.txt"

