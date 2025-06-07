#!/bin/bash
# Local testing script

echo "Testing known cases:"
echo "Case 1: 3 days, 93 miles, \$1.42"
result1=$(./run.sh 3 93 1.42)
echo "Result: $result1 (Expected: ~364.51)"

echo -e "\nCase 2: 1 day, 55 miles, \$3.60"
result2=$(./run.sh 1 55 3.6)
echo "Result: $result2 (Expected: ~126.06)"

echo -e "\nCase 3: 5 days, 173 miles, \$1337.90"
result3=$(./run.sh 5 173 1337.9)
echo "Result: $result3 (Expected: ~1443.96)"

echo -e "\nTesting edge cases:"
echo "Very short trip: 1 day, 10 miles, \$5"
./run.sh 1 10 5

echo "Very long trip: 14 days, 1000 miles, \$2000"
./run.sh 14 1000 2000
