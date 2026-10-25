---
title: "Assignment 05: Visualization"
author: "Alyssa Jessa"
---
# Visual Audit Note

## Plot Question

How does mean BMI compare across income groups over the NHANES survey cycles among adults aged 20–80 in the prepared classroom dataset? 

## Issues Checked
1
Issue: plot only shows the first and last NHANES cycles but claims BMI increased steadily across every cycle
Category: Correctness
Relavence: The two endpoints cannot show whether BMI increased consistently across all cycles
Correction: Include all avalibale cycles. 
2 
Issue: The y-axis is restricted to BMI values from 24 to 28
Category: Design
Relavence: Having a narrow scale exaggerates visual differences and could possibily remove calyes outside of those limits 
Correction: Use a scale that accommodates the summarized values and clearly label mean BMI
3
Issue: The title claims that low income drives rising obesity
Category: Interpretation
Realevance: This implies causation correlational cannot be established 
Correction: Use a neutral title describing mean BMI by income group and cycle

4
Issue: Subtitle says adults aged 20–80, but the code does not filter by age
Category: Correctness
Realevance: The data included may not match the population described in the subtitle
Correction: Filter for ages 20-80

5
Issue: The plot does not display or check group sample sizes
Category: Bias
Realevance: Groups with very few observations may produce unstable descriptive averages
Correction: Calculate group counts and retain income-cycle groups with at least n observations

6
Issue: The plot leaves out data source 
Category: Interpreting
Realevance: Readers could mistake the figure for a representative estimate of the American population
Correction:Add a caption stating the source, statistic, exclusions, and descriptive limitations



## Final Caption

This figure shows mean BMI by income group across NHANES survey cycles among adults aged 20–80 using the prepared NHANES Health Equity classroom dataset. The analysis is descriptive and unweighted. Records with missing BMI, income group, cycle, or age values are excluded, as are income-cycle groups with fewer than 30 observations. The figure describes patterns in the classroom dataset and does not establish causation or provide population-level estimates. 

## AI-Use Check
Used AI to run  cat assignments/assignment05-visualization/flawed-plot-code.R to asses all errors in code. 
