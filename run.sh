#!/bin/bash
DAYS="$1"
MILES="$2"
RECEIPTS="$3"

if [ $# -ne 3 ]; then
    exit 1
fi

# CORRECTED FORMULAS - Much smaller multipliers!
if [ "$DAYS" -eq 1 ]; then
    # 1-day: Small base + tiny mile rate + receipts
    base_amount=$(echo "scale=4; 50 + $MILES * 0.15 + $RECEIPTS" | bc)
    
elif [ "$DAYS" -eq 2 ]; then
    # 2-day: Different structure
    base_amount=$(echo "scale=4; 100 + $MILES * 0.25 + $RECEIPTS" | bc)
    
elif [ "$DAYS" -eq 3 ]; then
    # 3-day: MUCH smaller multiplier - this was your big error!
    base_amount=$(echo "scale=4; 200 + $MILES * 0.10 + $RECEIPTS * 0.50" | bc)
    
elif [ "$DAYS" -eq 4 ]; then
    base_amount=$(echo "scale=4; 150 + $MILES * 0.20 + $RECEIPTS * 0.80" | bc)
    
elif [ "$DAYS" -eq 5 ]; then
    high_receipts=$(echo "$RECEIPTS > 1000" | bc -l)
    if [ "$high_receipts" -eq 1 ]; then
        base_amount=$(echo "scale=4; 100 + $MILES * 0.05 + $RECEIPTS * 1.00" | bc)
    else
        base_amount=$(echo "scale=4; 300 + $MILES * 0.30 + $RECEIPTS" | bc)
    fi
    
elif [ "$DAYS" -ge 8 ]; then
    # Long trips: Very small multipliers
    base_amount=$(echo "scale=4; 500 + $MILES * 0.02 + $RECEIPTS * 0.90" | bc)
    
else
    # 6-7 days
    base_amount=$(echo "scale=4; 200 + $MILES * 0.15 + $RECEIPTS * 0.85" | bc)
fi

# Much smaller corrections
correction=0
receipts_rounded=$(printf "%.0f" "$RECEIPTS")

# Remove the huge lookup corrections - they were wrong
# if [ "$DAYS" -eq 3 ] && [ "$MILES" -eq 93 ]; then
#     correction=-1
# fi

final_amount=$(echo "scale=4; $base_amount + $correction" | bc)
printf "%.2f\n" "$final_amount"
