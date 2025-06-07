#!/bin/bash
DAYS="$1"
MILES="$2" 
RECEIPTS="$3"

if [ $# -ne 3 ]; then
    exit 1
fi

# CAPPED REIMBURSEMENT SYSTEM - Key Discovery!
# The 1960s system has CAPS to prevent abuse

if [ "$DAYS" -eq 1 ]; then
    # 1-day: Base + capped contributions
    base=150
    mile_contrib=$(echo "scale=2; $MILES * 0.4" | bc)
    mile_cap=$(echo "if ($mile_contrib > 200) 200 else $mile_contrib" | bc)
    receipt_cap=$(echo "if ($RECEIPTS > 500) 500 else $RECEIPTS" | bc)
    base_amount=$(echo "scale=2; $base + $mile_cap + $receipt_cap" | bc)
    
elif [ "$DAYS" -eq 2 ]; then
    # 2-day: Different caps  
    base=200
    mile_contrib=$(echo "scale=2; $MILES * 0.3" | bc)
    mile_cap=$(echo "if ($mile_contrib > 350) 350 else $mile_contrib" | bc)
    receipt_cap=$(echo "if ($RECEIPTS > 600) 600 else $RECEIPTS" | bc)
    base_amount=$(echo "scale=2; $base + $mile_cap + $receipt_cap" | bc)
    
elif [ "$DAYS" -eq 3 ]; then
    # 3-day: THIS WAS THE KEY - CAPPED SYSTEM!
    base=400
    mile_contrib=$(echo "scale=2; $MILES * 0.2" | bc)
    mile_cap=$(echo "if ($mile_contrib > 300) 300 else $mile_contrib" | bc)
    receipt_contrib=$(echo "scale=2; $RECEIPTS * 0.5" | bc)
    receipt_cap=$(echo "if ($receipt_contrib > 800) 800 else $receipt_contrib" | bc)
    base_amount=$(echo "scale=2; $base + $mile_cap + $receipt_cap" | bc)
    
elif [ "$DAYS" -eq 4 ]; then
    base=300
    mile_contrib=$(echo "scale=2; $MILES * 0.25" | bc)
    mile_cap=$(echo "if ($mile_contrib > 400) 400 else $mile_contrib" | bc)
    receipt_cap=$(echo "if ($RECEIPTS > 700) 700 else $RECEIPTS" | bc)
    base_amount=$(echo "scale=2; $base + $mile_cap + $receipt_cap" | bc)
    
elif [ "$DAYS" -eq 5 ]; then
    base=350
    mile_contrib=$(echo "scale=2; $MILES * 0.2" | bc)
    mile_cap=$(echo "if ($mile_contrib > 500) 500 else $mile_contrib" | bc)
    receipt_contrib=$(echo "scale=2; $RECEIPTS * 0.6" | bc)
    receipt_cap=$(echo "if ($receipt_contrib > 1000) 1000 else $receipt_contrib" | bc)
    base_amount=$(echo "scale=2; $base + $mile_cap + $receipt_cap" | bc)
    
else
    # 6+ days: Lower caps (vacation penalty)
    base=250
    mile_contrib=$(echo "scale=2; $MILES * 0.1" | bc)
    mile_cap=$(echo "if ($mile_contrib > 300) 300 else $mile_contrib" | bc)
    receipt_contrib=$(echo "scale=2; $RECEIPTS * 0.4" | bc)
    receipt_cap=$(echo "if ($receipt_contrib > 600) 600 else $receipt_contrib" | bc)
    base_amount=$(echo "scale=2; $base + $mile_cap + $receipt_cap" | bc)
fi

printf "%.2f\n" "$base_amount"
