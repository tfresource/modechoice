---
output: html_document
editor_options: 
  chunk_output_type: console
---
# Selecting a Preferred Nesting Structure {#nesting-selection-chapter}


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
## x dplyr::filter() masks dfidx::filter(), stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(modelsummary)
library(haven)
library(knitr)
library(kableExtra)
```

```
## 
## Attaching package: 'kableExtra'
```

```
## The following object is masked from 'package:dplyr':
## 
##     group_rows
```


```r
sf_work <- read_rds("data/worktrips.rds")
```

## Introduction

This chapter re-examines the San Francisco mode choice models estimated in [CHAPTER 6](#specification-chapter) and [CHAPTER 7](#other-purpose-chapter) and evaluates whether the MNL models should be replaced by nested logit models.  The final, un-segmented, specifications, Model 17W for work trips and Model 14 S/O for shop/other trips, are taken as the base specifications for estimating nested logit models .  Nested models for work trips are examined first, followed by shop/other trips.  The chapter concludes with consideration of the policy implications of adopting alternative nesting structures.  
Although the number of possible nests for six alternatives is large, the nature of the alternatives allows certain nests to be rejected as implausible.  For example, it is unreasonable to suppose that Bike and Transit have substantial unobserved characteristics that lead to correlation in the error terms of their utility functions.  For this reason, this chapter considers four plausible nests which are combined in different ways.  For Work trips , these are:
•	Motorized (M) alternatives, comprised of Drive Alone, Shared Ride 2, Shared Ride 3+, and Transit; 
•	Private automobile (P) alternatives, including Drive Alone, Shared Ride 2 and Shared Ride 3+ alternatives; 
•	Shared ride (S) alternatives; and 
•	Non-Motorized (NM) alternatives comprised of Bike and Walk.  
  
Given these four nests or groupings of alternatives and recognizing that Motorized includes both Automobile and Transit alternatives and that Automobile includes Drive Alone and the Shared Ride alternatives, fifteen nest structures as described below. We begin with four single nest models (and, based on the results of these estimations, we explore a selection of more complex structures.

<div class="figure">
<img src="img/Single_nest_models.png" alt="Single Nest Models" width="334" />
<p class="caption">(\#fig:SNModelsparallelfig)Single Nest Models</p>
</div>


## Nested Models for Work Trips

The estimation of nested logit models for work trips begins with consideration
of the four single nest models mentioned above and illustrated in Figure 9.1.
Each of these models obtains improved goodness-of-fit relative to the MNL model
(see Table \@ref(tab:singlenest-work)).  Three of the four models; Models 18W, 20W, 21W; result in
acceptable logsum parameters and two of these models (Models 18W and 20W)
significantly reject the MNL model at close to the 0.05 level (see the
chi-square test and significance in the Table
\@ref(tab:singlenest-lrt).  However, the model with the private automobile nest
(Model 19W) is rejected because the logsum parameter is greater than one and the
model with the non-motorized nest (Model 21W) cannot reject the MNL model at any
reasonable level.


```r
work_formula <- chosen ~ I(cost / hhinc) + mot_tvtt + nm_tvtt + movtbyds |  
                 hhinc + vehbywrk + I(wkccbd+wknccbd) + wkempden
m17w <- mlogit(work_formula, data = sf_work)
m18w <- mlogit(work_formula, data = sf_work, 
               nests = list(motorized = c('Drive alone', 'Share ride 2', 
                                          'Share ride 3+', 'Transit'),  
                            other = c('Bike', 'Walk')),
               constPar = c("iv:other" = 1))
m19w <- mlogit(work_formula, data = sf_work, 
               nests = list(privateauto = c('Drive alone', 'Share ride 2', 
                                          'Share ride 3+'),  
                            other = c('Bike', 'Walk', "Transit")),
               constPar = c("iv:other" = 1))
m20w <- mlogit(work_formula, data = sf_work,
               nests = list( shared_ride = c('Share ride 2', 'Share ride 3+'),  
                            other = c('Drive alone',  'Bike','Transit',  'Walk')),
               constPar = c("iv:other" = 1))
m21w <- mlogit(work_formula, data = sf_work,
               nests = list(non_motorized = c('Bike', 'Walk'),  
                            other = c('Drive alone','Share ride 2', 'Share ride 3+', 'Transit')),
               constPar = c("iv:other" = 1))
```



```r
this_map <- c(
  "I(cost/hhinc)" = "Travel Cost by Income" ,
  "mot_tvtt" = "Motorized Modes Travel Time",
  "nm_tvtt" = "Non-Motorized Modes Travel Time",
  "movtbyds" = "Motorized OVT by Distance",
#"hhinc:Share ride 2", 
#"hhinc:Share ride 3++", 
#"hhinc:Transit", 
#"hhinc:Bike", 
#"hhinc:Walk", 
#"vehbywrk:Share ride 2", 
#"vehbywrk:Share ride 3++", 
#"vehbywrk:Transit", 
#"vehbywrk:Bike", 
#"vehbywrk:Walk", 
#"wknccbd:Share ride 2", 
#"wknccbd:Share ride 3++", 
#"wknccbd:Transit", 
#"wknccbd:Bike", 
#"wknccbd:Walk", 
#"wkempden:Share ride 2", 
#"wkempden:Share ride 3++", 
#"wkempden:Transit", 
#"wkempden:Bike", 
#"wkempden:Walk",
"(Intercept):Share ride 2"   = "Constants Shared ride 2",
"(Intercept):Share ride 3++" = "Constant: Shared ride 3+", 
"(Intercept):Transit"        = "Constant: Transit", 
"(Intercept):Bike"           = "Constant: Bike", 
"(Intercept):Walk"           = "Constant: Walk",
"iv:motorized" = "Motorized Nesting Coefficient",
"iv:privateauto" = "Private Auto Nesting Coefficient",
"iv:shared_ride" = "Shared Ride Nesting Coefficient",
"iv:non_motorized" = "Non-Motorized Nesting Coefficient"
)

single_nest <- list(
  "Model 17W" = m17w,
  "Model 18W" = m18w,
  "Model 19W" = m19w,
  "Model 20W" = m20w,
  "Model 21W" = m21w
  )

modelsummary(single_nest,
             fmt = "%.4f", coef_map = this_map, statistic = "statistic", statistic_vertical = FALSE)
```

```
## Warning in sanity_ellipsis(vcov, ...): The `statistic_vertical` argument
## is deprecated and will be ignored. To display uncertainty estimates next to
## your coefficients, use a `glue` string in the `estimate` argument. See `?
## modelsummary`
```

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Model 17W </th>
   <th style="text-align:center;"> Model 18W </th>
   <th style="text-align:center;"> Model 19W </th>
   <th style="text-align:center;"> Model 20W </th>
   <th style="text-align:center;"> Model 21W </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Travel Cost by Income </td>
   <td style="text-align:center;"> -0.0528 </td>
   <td style="text-align:center;"> -0.0395 </td>
   <td style="text-align:center;"> -0.0593 </td>
   <td style="text-align:center;"> -0.0519 </td>
   <td style="text-align:center;"> -0.0523 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (-4.9053) </td>
   <td style="text-align:center;"> (-4.2108) </td>
   <td style="text-align:center;"> (-5.7704) </td>
   <td style="text-align:center;"> (-6.3229) </td>
   <td style="text-align:center;"> (-6.1333) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Motorized Modes Travel Time </td>
   <td style="text-align:center;"> -0.0202 </td>
   <td style="text-align:center;"> -0.0147 </td>
   <td style="text-align:center;"> -0.0201 </td>
   <td style="text-align:center;"> -0.0199 </td>
   <td style="text-align:center;"> -0.0199 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (-5.2937) </td>
   <td style="text-align:center;"> (-3.8350) </td>
   <td style="text-align:center;"> (-5.1626) </td>
   <td style="text-align:center;"> (-5.3383) </td>
   <td style="text-align:center;"> (-5.2238) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Non-Motorized Modes Travel Time </td>
   <td style="text-align:center;"> -0.0455 </td>
   <td style="text-align:center;"> -0.0463 </td>
   <td style="text-align:center;"> -0.0462 </td>
   <td style="text-align:center;"> -0.0454 </td>
   <td style="text-align:center;"> -0.0454 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (-7.8846) </td>
   <td style="text-align:center;"> (-7.8793) </td>
   <td style="text-align:center;"> (-7.8626) </td>
   <td style="text-align:center;"> (-7.7239) </td>
   <td style="text-align:center;"> (-7.9588) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Motorized OVT by Distance </td>
   <td style="text-align:center;"> -0.1326 </td>
   <td style="text-align:center;"> -0.1121 </td>
   <td style="text-align:center;"> -0.1358 </td>
   <td style="text-align:center;"> -0.1333 </td>
   <td style="text-align:center;"> -0.1348 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (-6.7530) </td>
   <td style="text-align:center;"> (-6.1534) </td>
   <td style="text-align:center;"> (-8.1074) </td>
   <td style="text-align:center;"> (-8.0397) </td>
   <td style="text-align:center;"> (-8.1464) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Constants Shared ride 2 </td>
   <td style="text-align:center;"> -1.6976 </td>
   <td style="text-align:center;"> -1.2544 </td>
   <td style="text-align:center;"> -2.3621 </td>
   <td style="text-align:center;"> -1.6378 </td>
   <td style="text-align:center;"> -1.6979 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (-11.9649) </td>
   <td style="text-align:center;"> (-5.1759) </td>
   <td style="text-align:center;"> (-10.6522) </td>
   <td style="text-align:center;"> (-13.1040) </td>
   <td style="text-align:center;"> (-12.6106) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Constant: Shared ride 3+ </td>
   <td style="text-align:center;"> -3.7733 </td>
   <td style="text-align:center;"> -2.7579 </td>
   <td style="text-align:center;"> -5.4127 </td>
   <td style="text-align:center;"> -2.2766 </td>
   <td style="text-align:center;"> -3.7731 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (-16.0157) </td>
   <td style="text-align:center;"> (-5.1891) </td>
   <td style="text-align:center;"> (-10.6748) </td>
   <td style="text-align:center;"> (-8.8225) </td>
   <td style="text-align:center;"> (-15.8012) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Constant: Transit </td>
   <td style="text-align:center;"> -0.6930 </td>
   <td style="text-align:center;"> -0.4163 </td>
   <td style="text-align:center;"> -0.8374 </td>
   <td style="text-align:center;"> -0.7012 </td>
   <td style="text-align:center;"> -0.6896 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (-2.7770) </td>
   <td style="text-align:center;"> (-1.9336) </td>
   <td style="text-align:center;"> (-3.4063) </td>
   <td style="text-align:center;"> (-2.9420) </td>
   <td style="text-align:center;"> (-2.8847) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Constant: Bike </td>
   <td style="text-align:center;"> -1.6233 </td>
   <td style="text-align:center;"> -1.3842 </td>
   <td style="text-align:center;"> -1.7911 </td>
   <td style="text-align:center;"> -1.6214 </td>
   <td style="text-align:center;"> -1.4406 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (-3.7840) </td>
   <td style="text-align:center;"> (-3.4839) </td>
   <td style="text-align:center;"> (-4.6187) </td>
   <td style="text-align:center;"> (-4.2150) </td>
   <td style="text-align:center;"> (-4.0044) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Constant: Walk </td>
   <td style="text-align:center;"> 0.0751 </td>
   <td style="text-align:center;"> 0.3337 </td>
   <td style="text-align:center;"> -0.0882 </td>
   <td style="text-align:center;"> 0.0737 </td>
   <td style="text-align:center;"> 0.0861 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.2151) </td>
   <td style="text-align:center;"> (0.8824) </td>
   <td style="text-align:center;"> (-0.2441) </td>
   <td style="text-align:center;"> (0.2071) </td>
   <td style="text-align:center;"> (0.2501) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Motorized Nesting Coefficient </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.7269 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (5.4832) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Private Auto Nesting Coefficient </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 1.4788 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (13.4001) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Shared Ride Nesting Coefficient </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.2994 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (3.0847) </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Non-Motorized Nesting Coefficient </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.7673 </td>
  </tr>
  <tr>
   <td style="text-align:left;box-shadow: 0px 1px">  </td>
   <td style="text-align:center;box-shadow: 0px 1px">  </td>
   <td style="text-align:center;box-shadow: 0px 1px">  </td>
   <td style="text-align:center;box-shadow: 0px 1px">  </td>
   <td style="text-align:center;box-shadow: 0px 1px">  </td>
   <td style="text-align:center;box-shadow: 0px 1px"> (4.1552) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Num.Obs. </td>
   <td style="text-align:center;"> 5029 </td>
   <td style="text-align:center;"> 5029 </td>
   <td style="text-align:center;"> 5029 </td>
   <td style="text-align:center;"> 5029 </td>
   <td style="text-align:center;"> 5029 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> AIC </td>
   <td style="text-align:center;"> 6941.6 </td>
   <td style="text-align:center;"> 6942.0 </td>
   <td style="text-align:center;"> 6929.1 </td>
   <td style="text-align:center;"> 6940.4 </td>
   <td style="text-align:center;"> 6944.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BIC </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Log.Lik. </td>
   <td style="text-align:center;"> -3441.782 </td>
   <td style="text-align:center;"> -3439.980 </td>
   <td style="text-align:center;"> -3433.532 </td>
   <td style="text-align:center;"> -3439.198 </td>
   <td style="text-align:center;"> -3441.156 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho2 </td>
   <td style="text-align:center;"> 0.2914 </td>
   <td style="text-align:center;"> 0.2918 </td>
   <td style="text-align:center;"> 0.2931 </td>
   <td style="text-align:center;"> 0.2919 </td>
   <td style="text-align:center;"> 0.2915 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho20 </td>
   <td style="text-align:center;"> 0.6180 </td>
   <td style="text-align:center;"> 0.6182 </td>
   <td style="text-align:center;"> 0.6190 </td>
   <td style="text-align:center;"> 0.6183 </td>
   <td style="text-align:center;"> 0.6181 </td>
  </tr>
</tbody>
</table>



```r
tibble(
  model_name = names(single_nest),
  model = single_nest,
) %>%
  mutate(
    loglik = map_dbl(model, logLik),
    lrtest = -2 * (loglik[1] - loglik) ,
    p.value = pchisq(lrtest, 1, lower.tail = FALSE)
  ) %>%
  select(-model) %>%
  kbl(col.names = c("Model", "Log Likelihood", "LR Test", "p-value")) %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Model </th>
   <th style="text-align:right;"> Log Likelihood </th>
   <th style="text-align:right;"> LR Test </th>
   <th style="text-align:right;"> p-value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Model 17W </td>
   <td style="text-align:right;"> -3441.782 </td>
   <td style="text-align:right;"> 0.000000 </td>
   <td style="text-align:right;"> 1.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Model 18W </td>
   <td style="text-align:right;"> -3439.980 </td>
   <td style="text-align:right;"> 3.603876 </td>
   <td style="text-align:right;"> 0.0576450 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Model 19W </td>
   <td style="text-align:right;"> -3433.532 </td>
   <td style="text-align:right;"> 16.500446 </td>
   <td style="text-align:right;"> 0.0000486 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Model 20W </td>
   <td style="text-align:right;"> -3439.198 </td>
   <td style="text-align:right;"> 5.168401 </td>
   <td style="text-align:right;"> 0.0230014 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Model 21W </td>
   <td style="text-align:right;"> -3441.156 </td>
   <td style="text-align:right;"> 1.251722 </td>
   <td style="text-align:right;"> 0.2632239 </td>
  </tr>
</tbody>
</table>


Next we consider three models with the non-motorized nest in parallel with each of the three other nests (Figure 9.2).  In each case, the new models in Table 9-2; Models 22W, 23W and 24W; have better goodness of fit than the corresponding single nest models.  Model 23W is rejected because the nest parameter for private automobile is greater than one, as before.  Models 22W and 23W both reject the single non-motorized nest (Model 21W) at close to the 0.05 level; however, neither rejects the corresponding Motorized and Shared Ride models (Models 18W and 20W, respectively).  In such cases, the analyst can decide to include the non-motorized nest or not, for other than statistical reasons.  

<div class="figure">
<img src="img/NMnestinParallel.PNG" alt="Non-Motorized Nest in Parallel with Motorized, Private Automobile and Shared Ride Nests" width="282" />
<p class="caption">(\#fig:NMparallelfig)Non-Motorized Nest in Parallel with Motorized, Private Automobile and Shared Ride Nests</p>
</div>


```r
m22w <- mlogit(work_formula, data = sf_work,
               nests = list(motorized = c('Drive alone', 'Share ride 2', 
                                          'Share ride 3+', 'Transit'),  
                            non_motorized = c('Bike', 'Walk')))
m23w <- mlogit(work_formula, data = sf_work,
               nests = list(auto = c('Drive alone', 'Share ride 2', 'Share ride 3+'),  
                            transit = c("Transit"), non_motorized = c('Bike', 'Walk')),
               constPar = c("iv:transit" = 1))
m24w <- mlogit(work_formula, data = sf_work,
               nests = list(shared = c('Share ride 2', 'Share ride 3+'),  
                            other = c("Drive alone", "Transit"), non_motorized = c('Bike', 'Walk')),
               constPar = c("iv:other" = 1))

parallel_nest <- list(
  "Model 17W" = m17w,
  "Model 22W" = m22w,
  "Model 23W" = m23w,
  "Model 24W" = m24w
  )
```


```r
modelsummary(parallel_nest,
             fmt = "%.4f", coef_map = this_map, statistic = "statistic", statistic_vertical = FALSE)
```

```
## Warning in sanity_ellipsis(vcov, ...): The `statistic_vertical` argument
## is deprecated and will be ignored. To display uncertainty estimates next to
## your coefficients, use a `glue` string in the `estimate` argument. See `?
## modelsummary`
```

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Model 17W </th>
   <th style="text-align:center;"> Model 22W </th>
   <th style="text-align:center;"> Model 23W </th>
   <th style="text-align:center;"> Model 24W </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Travel Cost by Income </td>
   <td style="text-align:center;"> -0.0528 </td>
   <td style="text-align:center;"> -0.0394 </td>
   <td style="text-align:center;"> -0.0585 </td>
   <td style="text-align:center;"> -0.0516 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (-4.9053) </td>
   <td style="text-align:center;"> (-4.2195) </td>
   <td style="text-align:center;"> (-5.6989) </td>
   <td style="text-align:center;"> (-6.2406) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Motorized Modes Travel Time </td>
   <td style="text-align:center;"> -0.0202 </td>
   <td style="text-align:center;"> -0.0146 </td>
   <td style="text-align:center;"> -0.0198 </td>
   <td style="text-align:center;"> -0.0195 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (-5.2937) </td>
   <td style="text-align:center;"> (-3.8326) </td>
   <td style="text-align:center;"> (-5.0862) </td>
   <td style="text-align:center;"> (-5.2275) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Non-Motorized Modes Travel Time </td>
   <td style="text-align:center;"> -0.0455 </td>
   <td style="text-align:center;"> -0.0463 </td>
   <td style="text-align:center;"> -0.0460 </td>
   <td style="text-align:center;"> -0.0446 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (-7.8846) </td>
   <td style="text-align:center;"> (-8.1136) </td>
   <td style="text-align:center;"> (-8.0568) </td>
   <td style="text-align:center;"> (-7.8563) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Motorized OVT by Distance </td>
   <td style="text-align:center;"> -0.1326 </td>
   <td style="text-align:center;"> -0.1138 </td>
   <td style="text-align:center;"> -0.1384 </td>
   <td style="text-align:center;"> -0.1344 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (-6.7530) </td>
   <td style="text-align:center;"> (-6.2360) </td>
   <td style="text-align:center;"> (-8.2700) </td>
   <td style="text-align:center;"> (-8.1193) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Constants Shared ride 2 </td>
   <td style="text-align:center;"> -1.6976 </td>
   <td style="text-align:center;"> -1.2583 </td>
   <td style="text-align:center;"> -2.3612 </td>
   <td style="text-align:center;"> -1.6373 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (-11.9649) </td>
   <td style="text-align:center;"> (-5.2194) </td>
   <td style="text-align:center;"> (-10.6454) </td>
   <td style="text-align:center;"> (-13.0660) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Constant: Shared ride 3+ </td>
   <td style="text-align:center;"> -3.7733 </td>
   <td style="text-align:center;"> -2.7657 </td>
   <td style="text-align:center;"> -5.4110 </td>
   <td style="text-align:center;"> -2.3204 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (-16.0157) </td>
   <td style="text-align:center;"> (-5.2323) </td>
   <td style="text-align:center;"> (-10.6689) </td>
   <td style="text-align:center;"> (-8.1172) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Constant: Transit </td>
   <td style="text-align:center;"> -0.6930 </td>
   <td style="text-align:center;"> -0.4151 </td>
   <td style="text-align:center;"> -0.8323 </td>
   <td style="text-align:center;"> -0.7057 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (-2.7770) </td>
   <td style="text-align:center;"> (-1.9268) </td>
   <td style="text-align:center;"> (-3.3868) </td>
   <td style="text-align:center;"> (-2.9593) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Constant: Bike </td>
   <td style="text-align:center;"> -1.6233 </td>
   <td style="text-align:center;"> -1.2033 </td>
   <td style="text-align:center;"> -1.6157 </td>
   <td style="text-align:center;"> -1.4757 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (-3.7840) </td>
   <td style="text-align:center;"> (-3.2425) </td>
   <td style="text-align:center;"> (-4.4488) </td>
   <td style="text-align:center;"> (-4.1092) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Constant: Walk </td>
   <td style="text-align:center;"> 0.0751 </td>
   <td style="text-align:center;"> 0.3451 </td>
   <td style="text-align:center;"> -0.0812 </td>
   <td style="text-align:center;"> 0.0657 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.2151) </td>
   <td style="text-align:center;"> (0.9398) </td>
   <td style="text-align:center;"> (-0.2320) </td>
   <td style="text-align:center;"> (0.1910) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Motorized Nesting Coefficient </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.7289 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (5.5350) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Non-Motorized Nesting Coefficient </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.7698 </td>
   <td style="text-align:center;"> 0.7652 </td>
   <td style="text-align:center;"> 0.7579 </td>
  </tr>
  <tr>
   <td style="text-align:left;box-shadow: 0px 1px">  </td>
   <td style="text-align:center;box-shadow: 0px 1px">  </td>
   <td style="text-align:center;box-shadow: 0px 1px"> (4.2012) </td>
   <td style="text-align:center;box-shadow: 0px 1px"> (4.1873) </td>
   <td style="text-align:center;box-shadow: 0px 1px"> (4.1389) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Num.Obs. </td>
   <td style="text-align:center;"> 5029 </td>
   <td style="text-align:center;"> 5029 </td>
   <td style="text-align:center;"> 5029 </td>
   <td style="text-align:center;"> 5029 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> AIC </td>
   <td style="text-align:center;"> 6941.6 </td>
   <td style="text-align:center;"> 6940.7 </td>
   <td style="text-align:center;"> 6929.8 </td>
   <td style="text-align:center;"> 6941.1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BIC </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Log.Lik. </td>
   <td style="text-align:center;"> -3441.782 </td>
   <td style="text-align:center;"> -3439.343 </td>
   <td style="text-align:center;"> -3432.889 </td>
   <td style="text-align:center;"> -3438.531 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho2 </td>
   <td style="text-align:center;"> 0.2914 </td>
   <td style="text-align:center;"> 0.2919 </td>
   <td style="text-align:center;"> 0.2932 </td>
   <td style="text-align:center;"> 0.2921 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho20 </td>
   <td style="text-align:center;"> 0.6180 </td>
   <td style="text-align:center;"> 0.6183 </td>
   <td style="text-align:center;"> 0.6190 </td>
   <td style="text-align:center;"> 0.6184 </td>
  </tr>
</tbody>
</table>


```r
tibble(
  model_name = names(parallel_nest),
  model = parallel_nest,
) %>%
  mutate(
    loglik = map_dbl(model, logLik),
    lrtest = -2 * (loglik[1] - loglik) ,
    p.value = pchisq(lrtest, 1, lower.tail = FALSE)
  ) %>%
  select(-model) %>%
  kbl(col.names = c("Model", "Log Likelihood", "LR Test", "p-value")) %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Model </th>
   <th style="text-align:right;"> Log Likelihood </th>
   <th style="text-align:right;"> LR Test </th>
   <th style="text-align:right;"> p-value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Model 17W </td>
   <td style="text-align:right;"> -3441.782 </td>
   <td style="text-align:right;"> 0.000000 </td>
   <td style="text-align:right;"> 1.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Model 22W </td>
   <td style="text-align:right;"> -3439.343 </td>
   <td style="text-align:right;"> 4.878942 </td>
   <td style="text-align:right;"> 0.0271863 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Model 23W </td>
   <td style="text-align:right;"> -3432.889 </td>
   <td style="text-align:right;"> 17.785788 </td>
   <td style="text-align:right;"> 0.0000247 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Model 24W </td>
   <td style="text-align:right;"> -3438.531 </td>
   <td style="text-align:right;"> 6.502062 </td>
   <td style="text-align:right;"> 0.0107749 </td>
  </tr>
</tbody>
</table>



Another option is to consider ‘hierarchical’ two nest models with Motorized and Private Automobile, Motorized and Shared Ride or Private Automobile and Shared Ride as illustrated in Figure 9.3.  Of the three models reported in Table 9-3, only Model 26W, Motorized and Shared Ride, produces an acceptable result.  Model 27W is rejected because the private automobile nest coefficient is greater than one, as before. Model 25W is also rejected, despite the fact that the automobile nest parameter is less than one because it is greater than the logsum parameter for the motorized nest which is above it (see [Section 8.4](#testing-NL-structures)).  Model 26W, however, represents an attractive model achieving the best goodness-of-fit of any of the models considered, with acceptable logsum parameters.  Further, it rejects the MNL model (Model 17W), the Motorized (Model 18W) and the Shared Ride (Model 20W) nest models at roughly the 0.03, 0.07 and 0.06 levels, respectively.

Table 9-4 presents four additional nested model structures for work trips.  The first two models extend the nesting structures previously estimated.  Model 28W adds the non-motorized nest to Model 26W (see Figure 9.4) with further improved goodness-of-fit, but cannot reject Model 26W at any reasonable level of significance.  Model 29W which includes the Motorized, Private Automobile and Shared Ride Nests (see Figure 9.3) is infeasible as it obtains a logsum for the automobile nest that is greater than for the motorized nest, as before.  However, Model 29W presents a structure that represents our expectation of the relationship among the motorized modes.  Thus, we estimate Model 30W which is identical to Model 29W except that it constrains the automobile nest parameter to 0.75 times the value of the motorized nest parameter.  While Model 30W results in a poorer goodness-of-fit than any of the other models including the simple MNL model; it is worth considering because it reflects increased substitution as we move from the Motorized Nest to the Private Automobile Nest to the Shared Ride Nest, as expected.  The data does not support this structure (relative to the MNL) but if the analyst or policy makers are convinced it is correct, the use of the relational constraint can produce a model consistent with these assumptions.

<div class="figure">
<img src="img/ComplexNests.PNG" alt="Complex Nested Models" width="361" />
<p class="caption">(\#fig:complexnestsfig)Complex Nested Models</p>
</div>

The final model, Model 31W, extends Model 30W by adding the Non-Motorized nest to the structure.  It therefore has the same issues regarding the constrained nest parameters, but it offers the advantage of including the substitution effects associated with all four nests previously selected.  Again, the decision on the acceptance of this model may be based primarily on the judgment of analysts and policy makers.

Based on these results, Models 26W, 28W, 30W and 31W are all potential candidates for a final model.  Model 26W is not rejected by any other model and is the simplest structure of this group.  Model 28W is slightly better than Model 26W but enough to statistically reject it.  Models 30W and 31W have a poorer goodness of fit than Model 26W and 28W, respectively but they incorporate the private automobile intermediate nest.  The decision about which of these models to use is largely a matter of judgment.  It is possible that other models might also be considered.
  We further examine Model 26W, because of its simplicity, to demonstrate the differences in direct-elasticity and cross-elasticity between the MNL (17W) model and pairs of alternatives in different parts of the NL tree associated with 26W.


```r
parallel_nest <- list(
  #"Model 17W" = m17w,
  #"Model 26W" = m26w
  )
```

The structure of the nested logit model (26W) in Figure 9.3 is reproduced here so that each nest can be readily identified.  The following table reports the elasticities for the MNL Model 17W and the NL Model 26W.

<div class="figure">
<img src="img/MSRnest.PNG" alt="Motorized-Shared Ride Nest (Model 26W)" width="184" />
<p class="caption">(\#fig:MSRfig)Motorized-Shared Ride Nest (Model 26W)</p>
</div>

It is apparent from the above table that reduction in the magnitude of the utility parameter for the NL model results in a lower direct and cross elasticity for alternatives that are in neither of the nests depicted in Figure 9.5 than they would have in the corresponding MNL model while alternatives in the lowest and intermediate nests have increased elasticity. The magnitude in of the elasticity increases as alternatives or pairs of alternatives are in lower nests in the tree.  Possibly, a better way to think about this is that adoption of the MNL model results in some type of averaged elasticities rather than the distinct elasticities for alternatives in a properly formed NL model.

## Nested Models for Shop / Other Trips

The exploration of nested logit models for shop/other trips follows the same approach as used with work trips, beginning with the consideration of four single nest models depicted in Figure 9.4.  For these trips, all four of the single nest structures produce valid models (Table 9-6).  Further, Models 15 S/O, 16 S/O and 17 S/O strongly reject the MNL model; however, the non-motorized nest (Model 18 S/O) does not reject the MNL model at any reasonable level of significance. 

```r
sf_shopother <- read_rds("data/shopother.rds")
#"Transit", "Share 2", "Share 3+","Drive alone and Share 2/3+", "Share 2/3+","Bike", "Walk", "Drive alone"
```


```r
#This table has the right idea, though I'm not sure what I can do to fix it or make it more accurate. I also don't know why it isn't showing the other constants...
SO_formula <- chosen ~ totcost + tvtt  + I(totcost/log(income)) + ovttdist |  
                 income + veh_wkr + ave_dens
m14SO <- mlogit(SO_formula, data = sf_shopother)
m15SO <- mlogit(SO_formula, data = sf_shopother,
               nests = list(motorized = c('Drive alone', 'Drive alone and Share 2/3+', 'Share 2/3+','Transit',
                                          'Share 2','Share 3+'),  
                             non_motorized = c('Bike', 'Walk')),
               constPar = c("iv:non_motorized" = 1))
m16SO <- mlogit(SO_formula, data = sf_shopother,
               nests = list(private_auto = c('Drive alone', 'Drive alone and Share 2/3+', 'Share 2/3+',
                                          'Share 2','Share 3+'), 
                            other = c('Transit', 'Bike', 'Walk')),
               constPar = c("iv:other" = 1))
m17SO <- mlogit(SO_formula, data = sf_shopother,
               nests = list(shared = c('Share 2/3+','Transit',
                                          'Share 2','Share 3+'),  
                            other = c("Drive alone", "Transit",'Bike', 'Walk','Drive alone and Share 2/3+')),
               constPar = c("iv:other" = 1))
m18SO <- mlogit(SO_formula, data = sf_shopother,
               nests = list(other = c('Drive alone', 'Drive alone and Share 2/3+', 'Share 2/3+','Transit',
                                          'Share 2','Share 3+'), 
                            non_motorized = c('Bike', 'Walk')),
               constPar = c("iv:other" = 1))

parallel_nests <- list(
  "Model 14SO" = m14SO,
  "Model 15SO" = m15SO,
  "Model 16SO" = m16SO,
  "Model 17SO" = m17SO,
  "Model 18SO" = m18SO
  )

modelsummary(parallel_nests,
             fmt = "%.4f", coef_map = this_map, statistic = "statistic", statistic_vertical = FALSE)
```

```
## Warning in sanity_ellipsis(vcov, ...): The `statistic_vertical` argument
## is deprecated and will be ignored. To display uncertainty estimates next to
## your coefficients, use a `glue` string in the `estimate` argument. See `?
## modelsummary`
```

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Model 14SO </th>
   <th style="text-align:center;"> Model 15SO </th>
   <th style="text-align:center;"> Model 16SO </th>
   <th style="text-align:center;"> Model 17SO </th>
   <th style="text-align:center;"> Model 18SO </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Constant: Bike </td>
   <td style="text-align:center;"> -7.7607 </td>
   <td style="text-align:center;"> -7.0614 </td>
   <td style="text-align:center;"> -7.0490 </td>
   <td style="text-align:center;"> -7.4427 </td>
   <td style="text-align:center;"> -6.6157 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (-9.6801) </td>
   <td style="text-align:center;"> (-5.0223) </td>
   <td style="text-align:center;"> (-7.7275) </td>
   <td style="text-align:center;"> (-7.6222) </td>
   <td style="text-align:center;"> (-8.2790) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Constant: Walk </td>
   <td style="text-align:center;"> -3.5504 </td>
   <td style="text-align:center;"> -2.7343 </td>
   <td style="text-align:center;"> -2.9676 </td>
   <td style="text-align:center;"> -3.1170 </td>
   <td style="text-align:center;"> -3.6332 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (-5.3377) </td>
   <td style="text-align:center;"> (-2.0550) </td>
   <td style="text-align:center;"> (-3.9906) </td>
   <td style="text-align:center;"> (-3.6214) </td>
   <td style="text-align:center;"> (-5.7231) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Motorized Nesting Coefficient </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 2.7352 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (3.6668) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Non-Motorized Nesting Coefficient </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.5724 </td>
  </tr>
  <tr>
   <td style="text-align:left;box-shadow: 0px 1px">  </td>
   <td style="text-align:center;box-shadow: 0px 1px">  </td>
   <td style="text-align:center;box-shadow: 0px 1px">  </td>
   <td style="text-align:center;box-shadow: 0px 1px">  </td>
   <td style="text-align:center;box-shadow: 0px 1px">  </td>
   <td style="text-align:center;box-shadow: 0px 1px"> (4.4713) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Num.Obs. </td>
   <td style="text-align:center;"> 3157 </td>
   <td style="text-align:center;"> 3157 </td>
   <td style="text-align:center;"> 3157 </td>
   <td style="text-align:center;"> 3157 </td>
   <td style="text-align:center;"> 3157 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> AIC </td>
   <td style="text-align:center;"> 9581.8 </td>
   <td style="text-align:center;"> 9570.9 </td>
   <td style="text-align:center;"> 9567.4 </td>
   <td style="text-align:center;"> 9576.5 </td>
   <td style="text-align:center;"> 9581.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BIC </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Log.Lik. </td>
   <td style="text-align:center;"> -4758.915 </td>
   <td style="text-align:center;"> -4751.453 </td>
   <td style="text-align:center;"> -4749.720 </td>
   <td style="text-align:center;"> -4754.236 </td>
   <td style="text-align:center;"> -4756.626 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho2 </td>
   <td style="text-align:center;"> 0.0668 </td>
   <td style="text-align:center;"> 0.0683 </td>
   <td style="text-align:center;"> 0.0686 </td>
   <td style="text-align:center;"> 0.0677 </td>
   <td style="text-align:center;"> 0.0673 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho20 </td>
   <td style="text-align:center;"> 0.2751 </td>
   <td style="text-align:center;"> 0.2762 </td>
   <td style="text-align:center;"> 0.2765 </td>
   <td style="text-align:center;"> 0.2758 </td>
   <td style="text-align:center;"> 0.2754 </td>
  </tr>
</tbody>
</table>

Despite the marginal significance of the non-motorized nest, the possible two parallel nest models including non-motorized and one other nest, were estimated and are reported in Table 9-7.  All three specifications result in valid models with improved goodness-of-fit over the MNL and the single nest NM model (Model 18 S/O) but Models 19 S/O, 20 S/O and 21 S/O do not reject the corresponding Motorized (Model 15 S/O), Private Automobile (Model 16 S/O) and Shared Ride (Model 17 S/O) nest models, which are restricted forms of these models, at a high level of confidence.  
It is important to note that a variety of different initial parameters were required to find the solution for Model 20 S/O reported here. The selection of different starting values for the model parameters, especially the nest parameter(s) may lead to convergence at different values in or out of the acceptable range as discussed in [CHAPTER 10](#nesting-optima-chapter).  

As in the case of work trips, hierarchical two-nest models, depicted in Figure 9.2, are considered next, Table 9-8.  Model 22 S/O obtains a satisfactory parameter for the automobile logsum but the motorized logsum is not significantly different from one and the model does not reject the single nest Private Automobile structure (Model 16 S/O).  However, Models 23 S/O (with shared ride under the motorized nest) and 24 S/O (with shared ride under the automobile nest) provide excellent results. The similarity interpretation of these nests is reasonable and both models strongly reject the MNL model and the constrained single nest models reported in Table 9-7.


```r
m22SO <- mlogit(work_formula, data = sf_work,
               nests = list(motorized = c('Drive alone', 'Share ride 2', 
                                          'Share ride 3+', 'Transit'),  
                            non_motorized = c('Bike', 'Walk')))
m23SO <- mlogit(work_formula, data = sf_work,
               nests = list(auto = c('Drive alone', 'Share ride 2', 'Share ride 3+'),  
                            transit = c("Transit"), non_motorized = c('Bike', 'Walk')),
               constPar = c("iv:transit" = 1))
m24SO <- mlogit(work_formula, data = sf_work,
               nests = list(shared = c('Share ride 2', 'Share ride 3+'),  
                            other = c("Drive alone", "Transit"), non_motorized = c('Bike', 'Walk')),
               constPar = c("iv:other" = 1))



parallel_nest <- list(
  #"Model 14SO" = m14SO,
  "Model 22SO" = m22SO,
  "Model 23SO" = m23SO,
  "Model 24SO" = m24SO
  )

modelsummary(parallel_nest)
```

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Model 22SO </th>
   <th style="text-align:center;"> Model 23SO </th>
   <th style="text-align:center;"> Model 24SO </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 2 </td>
   <td style="text-align:center;"> -1.258 </td>
   <td style="text-align:center;"> -2.361 </td>
   <td style="text-align:center;"> -1.637 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.241) </td>
   <td style="text-align:center;"> (0.222) </td>
   <td style="text-align:center;"> (0.125) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 3++ </td>
   <td style="text-align:center;"> -2.766 </td>
   <td style="text-align:center;"> -5.411 </td>
   <td style="text-align:center;"> -2.320 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.529) </td>
   <td style="text-align:center;"> (0.507) </td>
   <td style="text-align:center;"> (0.286) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Transit </td>
   <td style="text-align:center;"> -0.415 </td>
   <td style="text-align:center;"> -0.832 </td>
   <td style="text-align:center;"> -0.706 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.215) </td>
   <td style="text-align:center;"> (0.246) </td>
   <td style="text-align:center;"> (0.238) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Bike </td>
   <td style="text-align:center;"> -1.203 </td>
   <td style="text-align:center;"> -1.616 </td>
   <td style="text-align:center;"> -1.476 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.371) </td>
   <td style="text-align:center;"> (0.363) </td>
   <td style="text-align:center;"> (0.359) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Walk </td>
   <td style="text-align:center;"> 0.345 </td>
   <td style="text-align:center;"> -0.081 </td>
   <td style="text-align:center;"> 0.066 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.367) </td>
   <td style="text-align:center;"> (0.350) </td>
   <td style="text-align:center;"> (0.344) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I(cost/hhinc) </td>
   <td style="text-align:center;"> -0.039 </td>
   <td style="text-align:center;"> -0.059 </td>
   <td style="text-align:center;"> -0.052 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.009) </td>
   <td style="text-align:center;"> (0.010) </td>
   <td style="text-align:center;"> (0.008) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mot_tvtt </td>
   <td style="text-align:center;"> -0.015 </td>
   <td style="text-align:center;"> -0.020 </td>
   <td style="text-align:center;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.004) </td>
   <td style="text-align:center;"> (0.004) </td>
   <td style="text-align:center;"> (0.004) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> nm_tvtt </td>
   <td style="text-align:center;"> -0.046 </td>
   <td style="text-align:center;"> -0.046 </td>
   <td style="text-align:center;"> -0.045 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.006) </td>
   <td style="text-align:center;"> (0.006) </td>
   <td style="text-align:center;"> (0.006) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> movtbyds </td>
   <td style="text-align:center;"> -0.114 </td>
   <td style="text-align:center;"> -0.138 </td>
   <td style="text-align:center;"> -0.134 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.018) </td>
   <td style="text-align:center;"> (0.017) </td>
   <td style="text-align:center;"> (0.017) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 2 </td>
   <td style="text-align:center;"> 0.000 </td>
   <td style="text-align:center;"> -0.002 </td>
   <td style="text-align:center;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.001) </td>
   <td style="text-align:center;"> (0.002) </td>
   <td style="text-align:center;"> (0.001) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 3++ </td>
   <td style="text-align:center;"> 0.002 </td>
   <td style="text-align:center;"> 0.001 </td>
   <td style="text-align:center;"> 0.001 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.002) </td>
   <td style="text-align:center;"> (0.003) </td>
   <td style="text-align:center;"> (0.002) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Transit </td>
   <td style="text-align:center;"> -0.004 </td>
   <td style="text-align:center;"> -0.005 </td>
   <td style="text-align:center;"> -0.005 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.002) </td>
   <td style="text-align:center;"> (0.002) </td>
   <td style="text-align:center;"> (0.002) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Bike </td>
   <td style="text-align:center;"> -0.010 </td>
   <td style="text-align:center;"> -0.008 </td>
   <td style="text-align:center;"> -0.009 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.004) </td>
   <td style="text-align:center;"> (0.004) </td>
   <td style="text-align:center;"> (0.004) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Walk </td>
   <td style="text-align:center;"> -0.006 </td>
   <td style="text-align:center;"> -0.005 </td>
   <td style="text-align:center;"> -0.006 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.003) </td>
   <td style="text-align:center;"> (0.003) </td>
   <td style="text-align:center;"> (0.003) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Share ride 2 </td>
   <td style="text-align:center;"> -0.271 </td>
   <td style="text-align:center;"> -0.605 </td>
   <td style="text-align:center;"> -0.341 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.071) </td>
   <td style="text-align:center;"> (0.115) </td>
   <td style="text-align:center;"> (0.060) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Share ride 3++ </td>
   <td style="text-align:center;"> -0.107 </td>
   <td style="text-align:center;"> -0.257 </td>
   <td style="text-align:center;"> -0.278 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.082) </td>
   <td style="text-align:center;"> (0.164) </td>
   <td style="text-align:center;"> (0.070) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Transit </td>
   <td style="text-align:center;"> -0.705 </td>
   <td style="text-align:center;"> -0.862 </td>
   <td style="text-align:center;"> -0.948 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.145) </td>
   <td style="text-align:center;"> (0.110) </td>
   <td style="text-align:center;"> (0.104) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Bike </td>
   <td style="text-align:center;"> -0.736 </td>
   <td style="text-align:center;"> -0.599 </td>
   <td style="text-align:center;"> -0.699 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.197) </td>
   <td style="text-align:center;"> (0.197) </td>
   <td style="text-align:center;"> (0.195) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Walk </td>
   <td style="text-align:center;"> -0.764 </td>
   <td style="text-align:center;"> -0.612 </td>
   <td style="text-align:center;"> -0.713 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.139) </td>
   <td style="text-align:center;"> (0.141) </td>
   <td style="text-align:center;"> (0.139) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I(wkccbd + wknccbd) × Share ride 2 </td>
   <td style="text-align:center;"> 0.183 </td>
   <td style="text-align:center;"> 0.388 </td>
   <td style="text-align:center;"> 0.388 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.097) </td>
   <td style="text-align:center;"> (0.181) </td>
   <td style="text-align:center;"> (0.113) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I(wkccbd + wknccbd) × Share ride 3++ </td>
   <td style="text-align:center;"> 0.800 </td>
   <td style="text-align:center;"> 1.641 </td>
   <td style="text-align:center;"> 0.626 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.203) </td>
   <td style="text-align:center;"> (0.317) </td>
   <td style="text-align:center;"> (0.142) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I(wkccbd + wknccbd) × Transit </td>
   <td style="text-align:center;"> 0.920 </td>
   <td style="text-align:center;"> 1.364 </td>
   <td style="text-align:center;"> 1.324 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.220) </td>
   <td style="text-align:center;"> (0.185) </td>
   <td style="text-align:center;"> (0.179) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I(wkccbd + wknccbd) × Bike </td>
   <td style="text-align:center;"> 0.403 </td>
   <td style="text-align:center;"> 0.443 </td>
   <td style="text-align:center;"> 0.443 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.328) </td>
   <td style="text-align:center;"> (0.333) </td>
   <td style="text-align:center;"> (0.329) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I(wkccbd + wknccbd) × Walk </td>
   <td style="text-align:center;"> 0.107 </td>
   <td style="text-align:center;"> 0.117 </td>
   <td style="text-align:center;"> 0.105 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.235) </td>
   <td style="text-align:center;"> (0.240) </td>
   <td style="text-align:center;"> (0.238) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Share ride 2 </td>
   <td style="text-align:center;"> 0.001 </td>
   <td style="text-align:center;"> 0.003 </td>
   <td style="text-align:center;"> 0.002 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.000) </td>
   <td style="text-align:center;"> (0.001) </td>
   <td style="text-align:center;"> (0.000) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Share ride 3++ </td>
   <td style="text-align:center;"> 0.002 </td>
   <td style="text-align:center;"> 0.004 </td>
   <td style="text-align:center;"> 0.002 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.000) </td>
   <td style="text-align:center;"> (0.001) </td>
   <td style="text-align:center;"> (0.000) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Transit </td>
   <td style="text-align:center;"> 0.002 </td>
   <td style="text-align:center;"> 0.004 </td>
   <td style="text-align:center;"> 0.003 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.000) </td>
   <td style="text-align:center;"> (0.000) </td>
   <td style="text-align:center;"> (0.000) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Bike </td>
   <td style="text-align:center;"> 0.002 </td>
   <td style="text-align:center;"> 0.003 </td>
   <td style="text-align:center;"> 0.002 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.001) </td>
   <td style="text-align:center;"> (0.001) </td>
   <td style="text-align:center;"> (0.001) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Walk </td>
   <td style="text-align:center;"> 0.002 </td>
   <td style="text-align:center;"> 0.003 </td>
   <td style="text-align:center;"> 0.003 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.001) </td>
   <td style="text-align:center;"> (0.001) </td>
   <td style="text-align:center;"> (0.001) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> iv × motorized </td>
   <td style="text-align:center;"> 0.729 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.132) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> iv × non_motorized </td>
   <td style="text-align:center;"> 0.770 </td>
   <td style="text-align:center;"> 0.765 </td>
   <td style="text-align:center;"> 0.758 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.183) </td>
   <td style="text-align:center;"> (0.183) </td>
   <td style="text-align:center;"> (0.183) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> iv × auto </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 1.479 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.110) </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> iv × shared </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.320 </td>
  </tr>
  <tr>
   <td style="text-align:left;box-shadow: 0px 1px">  </td>
   <td style="text-align:center;box-shadow: 0px 1px">  </td>
   <td style="text-align:center;box-shadow: 0px 1px">  </td>
   <td style="text-align:center;box-shadow: 0px 1px"> (0.112) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Num.Obs. </td>
   <td style="text-align:center;"> 5029 </td>
   <td style="text-align:center;"> 5029 </td>
   <td style="text-align:center;"> 5029 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> AIC </td>
   <td style="text-align:center;"> 6940.7 </td>
   <td style="text-align:center;"> 6929.8 </td>
   <td style="text-align:center;"> 6941.1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BIC </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Log.Lik. </td>
   <td style="text-align:center;"> -3439.343 </td>
   <td style="text-align:center;"> -3432.889 </td>
   <td style="text-align:center;"> -3438.531 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho2 </td>
   <td style="text-align:center;"> 0.292 </td>
   <td style="text-align:center;"> 0.293 </td>
   <td style="text-align:center;"> 0.292 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho20 </td>
   <td style="text-align:center;"> 0.618 </td>
   <td style="text-align:center;"> 0.619 </td>
   <td style="text-align:center;"> 0.618 </td>
  </tr>
</tbody>
</table>

Unlike the case of the home-based work models, the home-based shop/other data set supports complex nested models which combine the hierarchical and parallel nests to capture the different substitutability between several groups of alternatives.  Models 25 S/O and 26 S/O improve goodness-of-fit over both the best hierarchical (Model 24 S/O) and parallel (Model 20 S/O) two-nest models.  These more complex models can reject all of the single nest models at the .05 level or higher, but cannot reject the best two-nest models at a high level of confidence.  Even so, they may still be preferred for their potentially more realistic representation of trade-offs between pairs of alternatives.  The same rationale could be applied between the two models, as Model 26 S/O cannot reject 25 S/O, either, but allows for greater substitutability between the non-motorized modes (for which the statistical evidence is moderately significant).  The nesting coefficient for the motorized nest is not particularly significant in either model, but it can be retained given the reasonableness of its value.  

## Practical Issues and Implications

A large number of nested logit structures can be proposed for any context in which the number of alternatives is not very small.  As seen, even in the case of four alternatives, there are 25 possible nest structures and this number increases to 235 for five alternatives and beyond 2000 for six or more alternatives.  Since searching across this many nest structures is generally infeasible, it is the responsibility of the analyst to propose a subset of these structures for primary consideration or, alternatively, to eliminate a subset of such structures from consideration.  At the same time, it is desirable for the analyst to remain open to other possible structures that may be suggested by others who have familiarity with the behavior under study.
	It is not uncommon for some or all of the proposed structures to be infeasible due to obtaining an estimated logsum or nesting parameter that is greater than one or greater than the parameter in a higher level nest.  It is a matter of judgment whether to eliminate the proposed structure based on the estimation results or to constrain selected nest parameters to fixed values or to relative values that ensure that the structure is consistent with utility maximization.  This ‘imposition’ of a fixed value or other constraints on nest parameters requires careful judgment, discussion with other modeling and policy analysts and open reporting so that potential users of the model are aware of the basis for the proposed model.
	An important part of the decision process is the differential interpretation associated with any nested logit model relative to the multinomial logit model or other nested logit models.  The central element of such interpretation is the way in which a change in any of the characteristics of an alternative affects the probability of that alternative and each other alternative being chosen.  This is the essential element of competition/substitution between pairs of alternatives and may dramatically influence the predicted impact of selected policy changes.

