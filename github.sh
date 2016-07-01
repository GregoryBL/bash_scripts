#!usr/bin/env bash

# extract the protocol
proto="$(echo $1 | sed -e's,^\(.*://\).*,\1,g')"
# remove the protocol
url="$(echo ${1#$proto})"

first_half="$(echo ${url%%/blob/*})"
last_half="$(echo ${url##*/blob/})"
first_front_removed="$(echo ${first_half#*/})"

curl -O "${proto}raw.githubusercontent.com/$first_front_removed/$last_half"