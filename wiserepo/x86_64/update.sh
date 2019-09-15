#!/bin/bash

rm wiserepo*


echo "repo-add"
repo-add wiserepo.db.tar.gz *.pkg.tar.xz
sleep 5

echo "####################################"
echo "Repo Updated!!"
echo "####################################"
