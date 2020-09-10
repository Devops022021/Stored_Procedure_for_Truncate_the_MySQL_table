#!/bin/bash
currentday=$(date +'%d-%m-%Y %H:%M:%S')
MAIL="test123@gmail.com"
count=$(mysql --login-path=root <dbname> -e "select count(1) as count from events_statements_summary_by_digest;" | grep -v "count")
if [ "$count" -gt 8000 ];
then
     mysql --login-path=root <dbname> -e "truncate table events_statements_summary_by_digest;"
 else
     exit
fi

####################################
#    Send mail if Truncate Fails   #
####################################

STATUS=$?
  if [ $STATUS -ne 0 ]
    then
     echo "Truncate failed on $currentday" | mail -s "truncate failed on <dbname>.events_statements_summary_by_digest table " ${MAIL}
   fi
