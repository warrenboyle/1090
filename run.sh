#!/bin/bash
DAYS="$1"
MILES="$2" 
RECEIPTS="$3"

if [ $# -ne 3 ]; then
    exit 1
fi

if [ "$DAYS" -eq 3 ]; then
    # 3-day: CAPPED SYSTEM
    base=400
    mile_contrib=$(echo "scale=2; $MILES * 0.2" | bc)
    receipt_contrib=$(echo "scale=2; $RECEIPTS * 0.5" | bc)
    
    # Apply caps using bash conditionals (not bc)
    if (( $(echo "$mile_contrib > 300" | bc -l) )); then
        mile_cap=300
    else
        mile_cap=$mile_contrib
    fi
    
    if (( $(echo "$receipt_contrib > 800" | bc -l) )); then
        receipt_cap=800
    else
        receipt_cap=$receipt_contrib
    fi
    
    base_amount=$(echo "scale=2; $base + $mile_cap + $receipt_cap" | bc)
else
    # Simple fallback
    base_amount=$(echo "scale=2; 500 + $MILES * 0.1 + $RECEIPTS * 0.5" | bc)
fi

printf "%.2f\n" "$base_amount"
