# VisCount

## Description
Visualisation tool for count compositional data and associated factors in R.

## Paper
Here

## Program Requirements
This program requires the R programming environment, which is freely [available here](https://www.r-project.org/). This tool uses the [ggvis](https://cran.r-project.org/web/packages/ggvis/index.html) and [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html) packages, although it will install these automatically when you run the program for the first time.

## Data Requirements


## Example
Once you have installed R and navigated into the VisCount directory in terminal, you can run the program using the example lemur dataset provided in the "data" directory:

`Rscript VisCount.R data/lemurs.txt tab 0.000001 Life.stage Species Individual`

This line has 8 words in it that do the following things:

Command | Purpose
--- | ---
`Rscript`| Calling the R language
`VisCount.R` | VisCount Program
`data/lemurs.txt` | Data file, includes path relative to program
`tab` | Separator in data file: can be "tab" or "comma" separated
`0.000001` | Value to replace 0s with if you log the data
`Life.stage` | First factor in data
`Species` | Second factor in data
`Individual` | Third factor in data

## Factors

Program can support up to three factors (values in different columns in the dataset)

Command | Purpose
--- | ---
Zero factors |
One factor |
Two factors |
Three factor |

## Logging Data

If you do not wish to have a log transform applied to your data, run the program with a 0 value instead of a value to replace the 0s with.

## Advanced Use



#### Name:
Int3n
#### Purpose:
Data visualisation demo using ggvis and data from the HMP
#### Version:
1.0
#### Licence:
MIT Licence
#### Author:
Jack Simpson (jack@jacksimpson.co)

#-------------------------------------------------------------------------------




- [x] This

1. First
2. Second
