# San Francisco Bay Area Shop / Other Mode Choice {#other-purpose-chapter}

```r
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.3.3     ✓ purrr   0.3.4
## ✓ tibble  3.1.0     ✓ dplyr   1.0.5
## ✓ tidyr   1.1.3     ✓ stringr 1.4.0
## ✓ readr   1.4.0     ✓ forcats 0.5.1
```

```
## Warning: package 'ggplot2' was built under R version 4.0.2
```

```
## Warning: package 'tibble' was built under R version 4.0.2
```

```
## Warning: package 'tidyr' was built under R version 4.0.2
```

```
## Warning: package 'readr' was built under R version 4.0.2
```

```
## Warning: package 'dplyr' was built under R version 4.0.2
```

```
## Warning: package 'forcats' was built under R version 4.0.2
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(haven)
```

```
## Warning: package 'haven' was built under R version 4.0.2
```

```r
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
sf_nonwork_raw <- read_spss()
sf_nonwork <- dfidx()
write_rds("data/sf_nonwork.rds")
```



```r
myshape <- st_read("data/some_shapefile.shp")
```



```r
models <- list()
models[['Bivariate']] <- lm(Girth ~ Height, data = trees)
models[['Multivariate']] <- lm(Girth ~ Height + Volume, data = trees)
```


```r
modelsummary(models, title = "Model Comparison")
```

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:model-comparison)Model Comparison</caption>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Bivariate </th>
   <th style="text-align:center;"> Multivariate </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:center;"> -6.188 </td>
   <td style="text-align:center;"> 10.816 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (5.960) </td>
   <td style="text-align:center;"> (1.973) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Height </td>
   <td style="text-align:center;"> 0.256 </td>
   <td style="text-align:center;"> -0.045 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.078) </td>
   <td style="text-align:center;"> (0.028) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Volume </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.195 </td>
  </tr>
  <tr>
   <td style="text-align:left;box-shadow: 0px 1px">  </td>
   <td style="text-align:center;box-shadow: 0px 1px">  </td>
   <td style="text-align:center;box-shadow: 0px 1px"> (0.011) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Num.Obs. </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 31 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:center;"> 0.270 </td>
   <td style="text-align:center;"> 0.941 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 Adj. </td>
   <td style="text-align:center;"> 0.244 </td>
   <td style="text-align:center;"> 0.937 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> AIC </td>
   <td style="text-align:center;"> 154.1 </td>
   <td style="text-align:center;"> 78.2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BIC </td>
   <td style="text-align:center;"> 158.4 </td>
   <td style="text-align:center;"> 84.0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Log.Lik. </td>
   <td style="text-align:center;"> -74.061 </td>
   <td style="text-align:center;"> -35.116 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F </td>
   <td style="text-align:center;"> 10.707 </td>
   <td style="text-align:center;"> 222.471 </td>
  </tr>
</tbody>
</table>


Table \@ref(tab:model-comparison) shows the estimated models. Figure \@ref(fig:group-mean-plot)
shows the grouped mean for three groups.


```r
# Generate some sample data, then compute mean and standard deviation
# in each group
df <- data.frame(
  gp = factor(rep(letters[1:3], each = 10)),
  y = rnorm(30)
)
ds <- do.call(rbind, lapply(split(df, df$gp), function(d) {
  data.frame(mean = mean(d$y), sd = sd(d$y), gp = d$gp)
}))
```



```r
# The summary data frame ds is used to plot larger red points on top
# of the raw data. Note that we don't need to supply `data` or `mapping`
# in each layer because the defaults from ggplot() are used.
ggplot(df, aes(gp, y)) +
  geom_point() +
  geom_point(data = ds, aes(y = mean), colour = 'red', size = 3) 
```

<div class="figure">
<img src="07-shopother_files/figure-html/group-mean-plot-1.png" alt="Grouped means." width="672" />
<p class="caption">(\#fig:group-mean-plot)Grouped means.</p>
</div>


## Specification for Shop/Other Mode Choice Model




## Initial Model Specification


## Exploring Alternative Specifications


