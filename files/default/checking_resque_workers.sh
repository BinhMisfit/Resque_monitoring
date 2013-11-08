#! /bin/bash

# set -x
key_word="var/www/apps/shineapi/releases/"
line=`ps -Ao command | grep $key_word`
echo $line

id=${line:37:40}
echo $id

line1=`ls -1 -t /var/www/apps/shineapi/releases`
echo $line1
id1=${line1:0:40}
echo $id1

body1="[RESQUE WORKERS ARE FINE]"
body2="[RESQUE WORKERS HAVE NOT UPDATED NEW CODES]"
body3="[FIXED ISSUES!]"
MESSAGE1="FINE!"

MESSAGE2="OMG! RESQUE WORKERS HAVE NOT RESTARTED AFTER RUNNING CHEF-CLIENT!"
MESSAGE3=" I HAVE RESTARTED RESQUE WORKERS! PLEASE CHECK IT AGAIN!"

ACTION=`sudo service resquewks-shineapi restart`
back_end_email1="chan@misfitwearables.com"
back_end_email2="binh@misfitwearables.com"
back_end_email3="khoathai@misfitwearables.com"
back_end_email4="quan@misfitwearables.com"
if [ "$id1" == "$id" ] 
then
  echo $MESSAGE1 | mail -s "$body1" "$back_end_email1" "$back_end_email2" "$back_end_email3" "$back_end_email4"
else
  echo $MESSAGE2 | mail -s "$body2" "$back_end_email" "$back_end_email2" "$back_end_email3" "$back_end_email4"
  echo "DO restart resque workers!"
  echo $ACTION
  echo "Finish!"
  echo $MESSAGE3 | mail -s "$body3" "$back_end_email" "$back_end_email2" "$back_end_email3" "$back_end_email4"
fi
