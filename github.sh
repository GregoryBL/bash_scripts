#!usr/bin/env bash

# extract the protocol
proto="$(echo $1 | sed -e's,^\(.*://\).*,\1,g')"
# remove the protocol
url="$(echo ${1#$proto})"

first_half="$(echo ${url%%/blob/*})"
last_half="$(echo ${url##*/blob/})"
first_front_removed="$(echo ${first_half#*/})"
final="$(echo ${proto}raw.githubusercontent.com/$first_front_removed/$last_half)"

if [ -e final ]
  then
  echo "Filename already exists. Replace? (y/n)"
  read user_answer

  if user_answer == 'y'
    then
    go_ahead=false
  else
    go_ahead=true
  fi
else
  go_ahead=true
fi

if go_ahead
  then
  curl -O "${proto}raw.githubusercontent.com/$first_front_removed/$last_half"
else
  echo "File not downloaded."
fi