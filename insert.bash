#!/bin/bash

working_directory="/home/uoasa05/public_html/ps5/"

# MySQL database credentials
mysql_username="uoasa05"
mysql_password="complex_password"
mysql_database="uoasa05"
# overwrite with real credentials here
source $working_directory"credentials.bash"

# execute autograder script
# pipe to subshell {} to preserve vars after loop
$working_directory"autograder.bash" | {
	# split on line output
	while IFS= read -r line
	do
		# split user & value
		array=($line)
		cols=$cols"${array[0]},"
		vals=$vals"${array[1]},"
	done
# remove trailing comma
cols="${cols%?}"
vals="${vals%?}"

# final SQL statement
sql="INSERT INTO ps5progress ($cols) VALUES ($vals);"
# write to database
mysql --user=$mysql_username --password=$mysql_password --database=$mysql_database --execute="$sql"
}