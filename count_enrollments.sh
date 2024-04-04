#!/bin/sh
# Script to check for more than 1000 enrollments per CSV file and dump a CSV report (log.csv) in the same directory

cd ~/Desktop/reporting_data/

for f in *.csv; 
do 
# Count the amount of commas in the line
count=$(cat ${f} | tr -cd , | wc -c)
# There will be one more number (or enrollment after the last comma) so incrementing by 1
count=$((count+1))

filename=$(echo ${f})
#echo "Filename: "$filename
portal_id=$(echo $filename | sed -e 's/[^(0-9|)]//g' | sed -e 's/|/,/g')
#echo "Filename: "$portal_id
#echo $count
# Here we check for any count that is greater than 200 and we out the file name and count
if [ $count -gt 1000 ];
then
    echo "The file '"${f}"' has "$count" enrollments";
    # Creating the CSV file by dumping the file name and count of enrollments here
    write_csv(){
        echo \"$1\",\"$2\",\"$3\" >> log.csv
    }
    write_csv ${f} $count $portal_id
# else
#     echo "The file '"${f}"' has ONLY "$count" enrollments";
fi
done;
