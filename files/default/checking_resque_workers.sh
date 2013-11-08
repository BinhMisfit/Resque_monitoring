#! /bin/bash

# set -x

sleep 15 # Delay a little bit after running chef-client (Maybe resque workers has not started immediately!)

echo "Checking..."
key_word="var/www/apps/shineapi/releases/"
line=`ps -Ao command | grep $key_word`
echo $line

id=${line:37:40}
echo "The current commit ID that resque workers are using:"
echo $id

echo "Checking..."
line1=`ls -1 -t /var/www/apps/shineapi/releases`
echo $line1
echo "The current commit ID that the web-server is using:"
id1=${line1:0:40}
echo $id1

hostname=`hostname -s`

body1="[RESQUE WORKERS IS FINE][$hostname]"
body2="[RESQUE WORKERS HAVE NOT UPDATED NEW CODES][$hostname]"
body3="[FIXED ISSUES!][$hostname]"
MESSAGE1="[$hostname] FINE!"

MESSAGE2="[$hostname] OMG! RESQUE WORKERS HAVE NOT RESTARTED AFTER RUNNING CHEF-CLIENT!"
MESSAGE3="[$hostname] I HAVE RESTARTED RESQUE WORKERS! FIXED IT!"

ACTION=`sudo service resquewks-shineapi restart`

back_end_email1="chan@misfitwearables.com"
back_end_email2="binh@misfitwearables.com"
back_end_email3="khoathai@misfitwearables.com"
back_end_email4="quan@misfitwearables.com"
back_end_email5="hoan@misfitwearables.com"
back_end_email6="winston@misfitwearables.com"
qa_email="thinh@misfitwearables.com"

if [ "$id1" == "$id" ] 
then
  echo "Resque workers are running with latest codes!!! Fine!"
  echo $MESSAGE1 | mail -s "$body1" "$qa_email" "$back_end_email1" "$back_end_email2" "$back_end_email3" "$back_end_email4" "$back_end_email5" "$back_end_email6"
else
  echo "Resque workers have not been updated!!!"
  echo $MESSAGE2 | mail -s "$body2" "$qa_email" "$back_end_email" "$back_end_email2" "$back_end_email3" "$back_end_email4" "$back_end_email5" "$back_end_email6" 
  echo "DO restart resque workers!"
  echo $ACTION
  echo "Finish!"
  echo $MESSAGE3 | mail -s "$body3" "$qa_email" "$back_end_email" "$back_end_email2" "$back_end_email3" "$back_end_email4" "$back_end_email5" "$back_end_email6"
fi
