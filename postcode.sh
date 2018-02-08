#!/bin/bash
while true; do
read -p "Enter City In Australia: " city
<<<<<<< HEAD
exam=$(curl -s -H "Authorization: Bearer d5cec761-148d-465a-b65a-5fb3d1cf38e3" http://localhost:8080/api/examples-services/postcode/$city)
=======
exam=$(curl -s -H "Authorization: Bearer d4075806-0c1d-47f2-a516-dc4acbc4c2a1" http://localhost:8080/api/examples-services/postcode/$city)
>>>>>>> ebd745e629b4444132832642ff02cf885093c792
asd=$(echo "$exam" | json_pp | grep -E '"' | cut -d \  -f7-30 | cut -d: -f1 | sed '/^$/d' | tr -d '"' | nl -s "." -w 3 )

if [[ "${asd}" ]] && [[ $city != *[[:punct:]]* ]]; then
    echo "${asd}"
    while true; do
    read -p "Enter Suburb in $city : " sub
    trya=$(echo "$exam" | json_pp | grep -E '"' | cut -d \  -f7-30 | cut -d: -f2 | tr -d '",,,' | sed '/^$/d' | sed -n ${sub}p )
    if [[ "${trya}" ]]; then
    echo "${trya}"
    break 3
  else
    echo "Invalid Suburb"
        fi
        done
else
    echo "Invalid City"
fi

done
<<<<<<< HEAD

=======
>>>>>>> ebd745e629b4444132832642ff02cf885093c792
