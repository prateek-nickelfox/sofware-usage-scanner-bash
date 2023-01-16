echo "Archiving the older version of the output file"
CURRENT_DATE=`date +%s`
mv users.txt "users-$CURRENT_DATE.txt"
mv occurence-atrifact.csv "users-$CURRENT_DATE.txt"
while read software
do 
    if [ -z "$software" ]
    then
        echo "Scan complete"
    else
        echo "------------------------------------------------" >> users.txt
        echo "Scanning " $software
        echo $software >> users.txt
        echo "------------------------------------------------" >> users.txt
        grep -rli all_files/ -e "$software" |  awk '{print substr($1,6)}' >> users.txt 
        echo "Gathering evidences..."
        grep -irn all_files/ -e "$software" |   awk -v software="$software" '{split(substr($0,6),a,":"); print a[1],",", software, "," a[2]}' >> occurence-atrifact.csv 
    fi
done < inputs.txt