# Table 1 Audit Note

## Cohort

The intended cohort includes adults ages 20-80 (inclusive). The correct code is filter(Age >= 20, Age <= 80). I beleive the missing values should be checked before excluding records for the summary for accuracy. 


## Missingness

The variables checked for missingness are BMI, Age, IncomeGroup, Gender, Race, and Cycle. Missing counts and percentages should be notes before creating the table. 

## Planted Issues

| Issue | Category | Why it matters | Corrected approach |
|---|---|---|---|
|  | Correctness |  |  |
|  | Reproducibility |  |  |
|  | Interpretation |  |  |
|  | Stewardship |  |  |
|  | Correctness |  |  |

| 1. Incorrect age filter | Correctness | Using > 20 and < 80 excludes people who are exactly 20 or 80. | Use filter(Age >= 20, Age <= 80). |
| 2. Removing all missing values | Correctness | na.omit() removes rows with missing values in any column, which could exclude unnecessary records. | Report missingness first, remove missing IncomeGroup for Table 1, and use na.rm = TRUE for the summaries. |
| 3. Variance instead of SD | Correctness | The code uses var() even though the table says mean (SD), giving incorrect and inaccurate values. | Use sd() instead of var(). |
| 4. Computer specific file path | Reproducibility | The C:/Users/analyst path may not work on other computers. | Use a relative path within the repository. |
| 5. Unsupported interpretation | Interpretation | The code claims statistical significance and causation without supporting evidence. | Describe the differences only and state that the analysis is unweighted and non-causal. |
| 6. Incorrect data source statement | Stewardship | The code says the data was downloaded last week, but it is a prepared classroom snapshot. | Identify it as a classroom dataset derived from public-use NHANES files. |


## AI Use Check
4. for error number 4 AI helped me me idenitfy what The C:/Users/analyst path was and why it is incorrect for this assignment. 