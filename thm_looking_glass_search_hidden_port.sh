#!/bin/bash

echo "This script is used for searching the hidden port on TryHackMe Looking Glass room"
echo "Room URL: https://tryhackme.com/room/lookingglass"

host='lookingglass.thm'

min_port=9000
max_port=13999

echo "Start searching ...(Press Enter when it hang too long)"
while :
do
	test_port=$(( ($max_port - $min_port)/2 + $min_port ))

	response=$(ssh anyuser@$host -oStrictHostKeyChecking=no -p$test_port)
	if [[ $response =~ 'Lower' ]]; then
		echo "Testing port $test_port"
		min_port=$test_port
		#echo "Your port should be higher than $test_port"
	elif [[ $response =~ 'Higher' ]]; then
		echo "Testing port $test_port"
		max_port=$test_port
		#echo "Your port should be lower than $test_port"
	else
		echo "The hidden port found!! $test_port"
		break
	fi
done
