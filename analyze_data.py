#!/usr/bin/env python3
import json
import pandas as pd
from collections import Counter

# Load the public cases
with open('public_cases.json', 'r') as f:
    data = json.load(f)

# Convert to DataFrame for analysis
df = pd.DataFrame(data)
print(f"Total cases: {len(df)}")
print("\nData structure:")
print(df.head())

print("\nTrip duration distribution:")
print(Counter(df['trip_duration_days']).most_common())

print("\nBasic statistics:")
print(df.describe())

# Look for patterns by trip duration
print("\nAverage output by trip duration:")
for days in sorted(df['trip_duration_days'].unique()):
    subset = df[df['trip_duration_days'] == days]
    avg_output = subset['expected_output'].mean()
    print(f"{days} days: {len(subset)} cases, avg output: ${avg_output:.2f}")

# Save to CSV for easier analysis
df.to_csv('cases_analysis.csv', index=False)
print("\nData saved to cases_analysis.csv for further analysis")
