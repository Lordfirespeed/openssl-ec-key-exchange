#!/usr/bin/env bash

experiment="x25519"

mkdir -p "$experiment"

openssl genpkey -algorithm x25519 -out "$experiment/joe_key.pem"
openssl pkey -in "$experiment/joe_key.pem" -pubout -out "$experiment/joe_pub.pem"

openssl genpkey -algorithm x25519 -out "$experiment/bea_key.pem"
openssl pkey -in "$experiment/bea_key.pem" -pubout -out "$experiment/bea_pub.pem"

openssl pkeyutl -derive -inkey "$experiment/joe_key.pem" -peerkey "$experiment/bea_pub.pem" | base64 > "$experiment/joe_secret.txt"
openssl pkeyutl -derive -inkey "$experiment/bea_key.pem" -peerkey "$experiment/joe_pub.pem" | base64 > "$experiment/bea_secret.txt"

