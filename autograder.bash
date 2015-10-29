#!/bin/bash

# get percentage functions
source /home/uoasa05/public_html/ps5/zzPCT.bash

# get all UOASA accounts into an array
cd /home
accts=( $(ls | grep uoasa) )

# create array of scores and initialize to zero
total=20
declare -a scores
for acct in "${accts[@]}"; do
	scores+=( 0 )
done

#1. folders to check
folders=( "/code" "/code/java" "/code/scripts" "/aboutme" "/other" )

i=0
for acct in "${accts[@]}"; do

	# check for individual account
	if ! [ -z $1 ]; then
		if [[ "$1" != "$acct" ]]; then
			continue
		fi
	fi

	#1. check to see if folders exist
	points=0
	for folder in "${folders[@]}"; do
		if [ -d /home/$acct$folder ]; then
			((points++))
		fi
	done
	if [[ "$1" == "$acct" ]]; then
		echo "1 "$points"/5"
	fi
	((scores[$i]+=$points))

	#2. check aboutme.txt in home folder
	points=0
	if [ -f /home/$acct/aboutme/aboutme.txt ]; then
		((points++))
	fi
	if [[ "$1" == "$acct" ]]; then
		echo "2 "$points
	fi
	((scores[$i]+=$points))

	#3. Copy the aboutme.txt file into the other folder.
	points=0
	if [ -f /home/$acct/other/aboutme.txt ]; then
		((points++))
	fi
	if [[ "$1" == "$acct" ]]; then
		echo "3 "$points
	fi
	((scores[$i]+=$points))

	#5. Edit file1.txt and change AMACKEY to your username. 
	# Move (not copy) this file to the aboutme folder.
	points=0
	if [ -f /home/$acct/aboutme/file1.txt ] && grep -q -i "User $acct created this file" /home/$acct/aboutme/file1.txt; then
		((points++))
	fi
	if [[ "$1" == "$acct" ]]; then
		echo "5 "$points
	fi
	((scores[$i]+=$points))

	#6. Edit file2.txt by selecting which operating system is your favorite. 
	# Move (not copy) this file to the aboutme folder.
	points=0
	if [ -f /home/$acct/aboutme/file2.txt ] && ! grep -q -i "Linux/zOS/MacOS/Windows is the best!" /home/$acct/aboutme/file1.txt; then
		((points++))
	fi
	if [[ "$1" == "$acct" ]]; then
		echo "6 "$points
	fi
	((scores[$i]+=$points))
	
	#7. Move (not copy) file3.txt to the other folder.
	points=0
	if ! [ -f /home/$acct/file3.txt ] && [ -f /home/$acct/other/file3.txt ]; then
		((points++))
	fi
	if [[ "$1" == "$acct" ]]; then
		echo "7 "$points
	fi
	((scores[$i]+=$points))
	
	#8. Delete file4.txt.
	points=0
	if [ -f /home/$acct/aboutme/file1.txt ] && ! [ -f /home/$acct/file4.txt ]; then
		((points++))
	fi
	if [[ "$1" == "$acct" ]]; then
		echo "8 "$points
	fi
	((scores[$i]+=$points))
	
	#9. Append date
	points=0
	if [ -f /home/$acct/aboutme/file1.txt ]; then
		# check appended, not clobbered
		linecount=$( cat /home/$acct/aboutme/file1.txt | wc -l )
		if [ $linecount -gt 1 ]; then
			dateline=$( tail -1 /home/$acct/aboutme/file1.txt )
			# if date format successfully parsed
			if $(date --date="$dateline" >/dev/null 2>&1) ; then
				((points++))
			fi
			
		fi
	fi
	if [ -f /home/$acct/aboutme/file2.txt ]; then
		# check appended, not clobbered
		linecount=$( cat /home/$acct/aboutme/file2.txt | wc -l )
		if [ $linecount -gt 1 ]; then
			dateline=$( tail -1 /home/$acct/aboutme/file2.txt )
			# if date format successfully parsed
			if $(date --date="$dateline" >/dev/null 2>&1) ; then
				((points++))
			fi
			
		fi
	fi
	if [[ "$1" == "$acct" ]]; then
		echo "9 "$points"/2"
	fi
	((scores[$i]+=$points))
	
	#10. Copy LoopExample.java and Test.java
	points=0
	if [ -f /home/$acct/code/java/LoopExample.java ]; then
		((points++))
	fi
	if [ -f /home/$acct/code/java/Test.java ]; then
		((points++))
	fi
	if [[ "$1" == "$acct" ]]; then
		echo "10 "$points"/2"
	fi
	((scores[$i]+=$points))
	
	#12. compile java
	points=0
	if [ -f /home/$acct/code/java/LoopExample.class ]; then
		((points++))
	fi
	if [ -f /home/$acct/code/java/Test.class ]; then
		((points++))
	fi
	if [[ "$1" == "$acct" ]]; then
		echo "12 "$points"/2"
	fi
	((scores[$i]+=$points))
	
	#14. run LoopExample and save the output to the other directory as “javaloop.txt”
	points=0
	if [ -f /home/$acct/other/javaloop.txt ]; then
		((points++))
		#15.
		if ! grep -q -i "Line 1:	Welcome to Java running on Linux" /home/$acct/other/javaloop.txt; then
			if ! grep -q -i "Line 3:	Welcome to Java running on Linux" /home/$acct/other/javaloop.txt; then
				if ! grep -q -i "Line 5:	Welcome to Java running on Linux" /home/$acct/other/javaloop.txt; then
					((points++))
				fi
			fi
		fi
	fi
	if [[ "$1" == "$acct" ]]; then
		echo "14-15 "$points"/2"
	fi
	((scores[$i]+=$points))
	
	#17. save the output from the “tree” command to the other directory as “files.txt”
	points=0
	if [ -f /home/$acct/other/files.txt ]; then
		((points++))
	fi
	if [[ "$1" == "$acct" ]]; then
		echo "17 "$points
	fi
	((scores[$i]+=$points))
	
	((i++))
done

# print out final % complete
if [ -z $1 ]; then
	i=0
	for acct in "${accts[@]}"; do
		echo $acct" "$( zzPCT ${scores[$i]} $total 3 )
		((i++))
	done
fi
