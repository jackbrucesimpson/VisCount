# VisCount

## Description
Visualisation tool for count compositional data and associated factors in R.

resize
0-3 factors
count data
coloured, filtered
log

![alt text](images/program_pic.png)

## Demonstration

A demonstration of the tool on the example lemur dataset will be available on a website shortly.

## Paper
In progress.

## Program Requirements
This program requires the R programming environment, which is freely [available here](https://www.r-project.org/). This tool uses the [ggvis](https://cran.r-project.org/web/packages/ggvis/index.html) and [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html) packages, although it will install these automatically when you run the program for the first time.

## Data Requirements

Data is required to be in the form of a CSV (comma separated file) or TSV (tab separated file) and to have a header for each column. Factors should be in their own column, and you can have between 0-3 factors.

![alt text](images/data_layout.png)

For an example of the correct data structure, please see the example dataset in the "data" directory.

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

Please note that the order you write this in is important - while you can vary the number of factors based on how many are present in your dataset, the factors you name must always come last when you run the program, even if there are none.

## Factors

The VisCount program can support up to three factors. Depending on how many factors your dataset contains, the following will happen:

Command | Purpose
--- | ---
Zero factors | The points will be plotted without colour.
One factor | Points will be coloured and filtered based on this factor.
Two factors | Points will be filtered based on both factors. The factor with the most levels will be used to colour the points, while the other factor will provide the coloured stroke around the points.
Three factors | Points will be filtered based on all 3 factors. Same as with 2 factors except the factor with the fewest levels will be used to set the shape of the points.

## Logging Data

If you do not wish to have a log transform applied to your data, run the program with a 0 value instead of a value to replace the 0s with.

## Advanced Use



## Licence


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
