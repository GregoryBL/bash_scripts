#!usr/bin/env bash

# extract the protocol
proto="$(echo $1 | sed -e's,^\(.*://\).*,\1,g')"
# remove the protocol
url="$(echo ${1#$proto})"

first_half="$(echo ${url%%/blob/*})"
last_half="$(echo ${url##*/blob/})"
first_front_removed="$(echo ${first_half#*/})"
final="$(echo ${proto}raw.githubusercontent.com/$first_front_removed/$last_half)"

filename="$(echo ${last_half##*/})"
echo "Downloading: $filename"

asksure() {
  echo "Are you sure (Y/N)? "
  while read -r -n 1 -s answer; do
    if [[ $answer = [YyNn] ]]; then
      [[ $answer = [Yy] ]] && retval=0
      [[ $answer = [Nn] ]] && retval=1
      break
    fi
  done

echo # just a final linefeed, optics...

return $retval
}

if [ -e $filename ]
  then
  echo "File already exists."
  if asksure
    then
    curl -O "${proto}raw.githubusercontent.com/$first_front_removed/$last_half"
  else
    echo "File not downloaded."
  fi
else
  curl -O "${proto}raw.githubusercontent.com/$first_front_removed/$last_half"
fi