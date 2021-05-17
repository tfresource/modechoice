# San Francisco Bay Area Shop / Other Mode Choice {#other-purpose-chapter}

```r
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.3.3     ✓ purrr   0.3.4
## ✓ tibble  3.1.1     ✓ dplyr   1.0.5
## ✓ tidyr   1.1.3     ✓ stringr 1.4.0
## ✓ readr   1.4.0     ✓ forcats 0.5.1
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(haven)
library(mlogit)
```

```
## Loading required package: dfidx
```

```
## 
## Attaching package: 'dfidx'
```

```
## The following object is masked from 'package:stats':
## 
##     filter
```

```r
library(modelsummary)
```

[Chapter 7](#other-purpose-chapter)

## Introduction



```r
sf_shopother_raw <- read_spss("data-raw/Shopping Trips/SPSS/MTC Shopping v2.SAV") %>%
  mutate(ALTNAME = factor(ALTID, labels = c("Transit", "Share 2", "Share 3+","Drive alone and Share 2/3+",
                                               "Share 2/3+","Bike", "Walk", "Drive alone")))
names(sf_shopother_raw) <- tolower(names(sf_shopother_raw))
sf_shopother <- dfidx(sf_shopother_raw, idx = c("casenum", "altname"))

# write to data/ folder for future use
write_rds(sf_shopother, "data/shopother.rds")
```

#add labels to alternative names


## Specification for Shop/Other Mode Choice Model




## Initial Model Specification


## Exploring Alternative Specifications


