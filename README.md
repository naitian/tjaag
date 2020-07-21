# Data Repository for TJ Alumni Action Group

This repository tracks data preprocessing and analysis for the Research and
Analysis subcommittee.

## How to use this repository

### Dependencies

You should have R installed.

You should also install the R packages `arsenal` and `tidyverse`. You can do
this by launching R and running

```r
install.packages(c("arsenal", "tidyverse"))
```

Finally, if you'd like to use the Makefile, you should have `make` and `wget`
installed, and be running on a Unix system. Otherwise, you can do things
manually, and that will work just as well (but with some extra steps).

### Using the Makefile

I've included a Makefile to simplify processes if you are running on a
Unix system (MacOS, Linux, Windows Subsystem for Linux, etc). The Makefile
expects `make` and `wget` to be installed.

To run the preprocessing script, you can either run `make preprocess`.

This automatically downloads three Excel files to be in the `raw_data`
directory: `raw_data/Admissions_Data_2009.xls`,
`raw_data/Admissions_Data_2010.xls`, and `raw_data/Admissions_Data_2011.xls`,
runs the preprocessing script, and outputs the combined CSV file as
`data/tjadm_all_2009_2011.csv`

### Running things manually

If you can't or prefer not to use the Makefile, you can also manually download
the raw data files from
[http://fcag.org/tjstatistics.shtml](http://fcag.org/tjstatistics.shtml) into a
`raw_data` directory, create a `data` directory, and run the R script.

### Data Dictionary

[http://www.fcag.org/documents/tj/tj-admissions-data-codes-explained.pdf](http://www.fcag.org/documents/tj/tj-admissions-data-codes-explained.pdf)

## Contributors

- Lesley Park Newman
- Naitian Zhou
