---
output: html_document
editor_options: 
  chunk_output_type: console
---
# Model Specification Refinement: San Francisco Bay Area Work Mode Choice {#specifcation-chapter}

```r
library(mlogit)
```

```
## Warning: package 'mlogit' was built under R version 4.0.3
```

```
## Loading required package: dfidx
```

```
## Warning: package 'dfidx' was built under R version 4.0.3
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
## -- Attaching packages ------------------------ tidyverse 1.3.0 --
```

```
## v ggplot2 3.3.2     v purrr   0.3.4
## v tibble  3.0.3     v dplyr   1.0.2
## v tidyr   1.1.2     v stringr 1.4.0
## v readr   1.3.1     v forcats 0.5.0
```

```
## -- Conflicts --------------------------- tidyverse_conflicts() --
## x dplyr::filter() masks dfidx::filter(), stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(modelsummary)
```

```
## Warning: package 'modelsummary' was built under R version 4.0.3
```

```r
library(haven)
library(knitr)
library(kableExtra)
```

```
## Warning: package 'kableExtra' was built under R version 4.0.3
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



## Introduction
This chapter describes and demonstrates the refinement of the utility function specification for
the multinomial logit (MNL) model for work mode choice in the San Francisco Bay Area. The
process combines the use of intuition, statistical analysis and testing, and judgment. The
intuition and judgment components of the model refinement process are based on theory,
anecdotal evidence, logical analysis, and the accumulated empirical experience of the model
developer. This empirical experience can be and often is enhanced through the advice of others
or through review of reports and published papers documenting previous modeling studies for
similar choice problems and contexts.

We explore a variety of different specifications of the utility functions to demonstrate
some of the most common specifications and testing methods. These tests include both formal
statistical tests and informal judgments about the signs, magnitudes, or relative magnitudes of
parameters based on our knowledge about the underlying behavioral relationships that influence
mode choice. The use of judgment and experience is an essential element of successful model
development since it is almost impossible to determine the “best” model specification solely on
the basis of statistical tests. A model that fits the data well may not necessarily describe the
causal relationships and may not produce the most reasonable predictions. Also, it is not
uncommon to find several model specifications that, for all practical purposes, fit the data
equally well, but which have very different specifications and forecast implications. Therefore,
practical model building involves considerable use of subjective judgment and is as much an art
as it is a science.

Different modelers have different styles and approaches to the model development
process. One of the most common approaches is to start with a minimal specification which
includes those variables that are considered essential to any reasonable model. In the case of
mode choice, such a specification might include travel time, travel cost and departure frequency
where appropriate for each alternative. Working from this minimal specification, incremental
changes are proposed and tested in an effort to improve the model in terms of its behavioral
realism and/or its empirical fit to the data while avoiding excessive complexity of the model.
Another common approach is to start with a richer specification which represents the model
developer’s judgment about the set of variables that is likely to be included in the final model
specification. For example, such a model might include travel time (separated into in-vehicle
and out-of-vehicle time), out of vehicle travel time might be adjusted to take account of the total
distance traveled, out of pocket travel cost (possibly adjusted by household income), frequency
of departure for carrier modes, household automobile ownership or availability, household
income, and size of the travel party. 

We adopt the first of these methods in the following section for refinement of the
specification of a model of work mode choice as it is the most appropriate approach for those
who are new to discrete choice modeling. At each stage in the model development process, we
introduce incremental changes to the modal utility functions and re-estimate the model with the
objective of finding a more refined model specification that performs better statistically and is
consistent with theory and our *a priori* expectations about mode choice behavior. We introduce
small changes at each step as the estimation results for each stage provide useful insights which
may be helpful in further refining the model. The appropriateness of each specification change
is evaluated at each step using both judgmental and statistical tests.
 In the rest of this chapter, we describe and demonstrate this process for work mode
choice in the San Francisco Bay Area.

## Alternative Specifications
The basic multinomial logit mode choice model for work commute in the San Francisco Bay
Area was reported in Table 5-2 \@ref(tab:basic-estimation-table) in [CHAPTER 5](#chapter5) . The refinements we consider include:
  - Different specifications of the income effects,
  - Different specifications of travel time,
  - Additional decision maker related variables such as gender and automobiles owned,
  - Additional variables that represent the interaction of decision maker related variables
    with mode related variables (*e.g.*, interaction of income with cost), and
  - Additional trip context variables (*e.g.*, dummy variable indicating if the trip
    origin/destination is in a Central Business District).
    
### Refinement of Specification for Alternative Specific Income Effects
The estimation results for the base model in [CHAPTER 5](#chapter5) yielded time and cost parameter
estimates that had the expected (negative) sign and were statistically significant. The parameters
for the alternative specific income variables were significant and had the expected sign (negative
relative to drive alone) except for the shared ride specific income variables (shared ride 2 and
shared ride 3+) which were not significant and the sign on the shared ride 3+ income variable
was counter-intuitive. All else being equal, we expect the preference for shared ride 2 to be
negative relative to drive alone and for shared ride 3+ to be more negative than shared ride 2
because of the increasing inconvenience of coordinating with other travelers as the number of
persons in the ride sharing group increases. However, the empirical results provide only limited
support for the first expectation and are inconsistent with the second expectation. This suggests
that the effect of income on choice is not necessarily different among the automobile modes.

We approach this inconsistency between expectation and empirical results by thinking of
other plausible relationships for the effect of income on shared ride choice and developing
alternative specifications which represent these relationships. Options for consideration include: 

  - The effect of income relative to drive alone is the same for the two shared ride modes (shared
    ride 2 and shared ride 3+) but is different from drive alone and different from the other
    modes. This relationship is represented by constraining the income coefficients in the two
    shared alternatives to be equal as follows: 
    
\begin{equation}
H_0 : \beta_{IncomeSR2} = \beta_{IncomeSR3+}
(\#eq:incomeandsharedrides)
\end{equation}
    
  - The effect of income relative to drive alone is the same for both shared ride modes and
    transit but is different for the other modes. This is represented in the model by constraining
    the income coefficients in both shared ride modes and the transit mode to be equal as: 
    
\begin{equation}
H_0 : \beta_{Income-SR2} = \beta_{Income-SR3+} = \beta_{Income-Transit}
(\#eq:incomeonsharedrideandtransit)
\end{equation}

  - The effect of income on all the automobile modes (drive alone, shared ride 2, and shared
    ride 3+) is the same, but the effect is different for the other modes. We include this
    constraint by setting the income coefficients in the utilities of the automobile modes to be
    equal. In this case, we set them to zero since drive alone is the reference mode. 
    
\begin{equation}
H_0 : \beta_{IncomeSR2} = \beta_{IncomeSR3+} = 0
(\#eq:automotivemodessame)
\end{equation}
    
The estimation results for the base model (from [CHAPTER 5](#chapter5)) and for these three alternative
models are reported in Table 6-1. The parameter estimates for all three models are consistent
with expectations. That is, the effect of increasing income is neutral or negative for the shared
ride modes relative to drive alone and equal to or more negative for transit, bike and walk than
for shared ride. Further, all the parameters are significant except for the shared ride income
parameters in Model 1W. 

Selection of one of these four models to represent the effect of income should consider
the statistical relationships among them and the reasonableness of the resultant models. Since
Models 1W, 2W and 3W are constrained versions of the Base Model and Models 2W and 3W
are constrained versions of Model 1W, we can use the likelihood ratio test to evaluate the
hypotheses implied by each of these models (see [section 5.7.3.2](#section5-7-3-2)). We use this test to determine
if the hypothesis that each of these models is the true model is or is not rejected by the less
restricted model. The likelihood ratio statistics (equation 5.16), the degrees of freedom or
number of restrictions and the level of significance for each test are reported relative to the Base
Model and to Model 1W in the first and second rows of Table 6-2, respectively. The Base
Model cannot reject any of the subsequent models at a reasonable level of significance. Further,
the Base Model has a counter-intuitive relationship between the parameters for shared ride 2 and
shared ride 3+. Thus, Model 1W or Model 3W can represent the effect of income on mode
choice in this case. We choose Model 1W because it is most consistent with our prior
hypotheses about the effect of income on preference between drive alone and shared ride and
other modes. However, the differences among these models are small both statistically and
behaviorally so the decision should be subject to a review before adoption of the final
specification [^statbasis].

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:Table-6-1 alternative Specifications of Income)Alternative Specifications of Income Variable</caption>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Base Model </th>
   <th style="text-align:center;"> Model 1W </th>
   <th style="text-align:center;"> Model 2W </th>
   <th style="text-align:center;"> Model 3W </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 2 </td>
   <td style="text-align:center;"> -2.1780 </td>
   <td style="text-align:center;"> -2.1780 </td>
   <td style="text-align:center;"> -2.1780 </td>
   <td style="text-align:center;"> -2.3043 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1046) </td>
   <td style="text-align:center;"> (0.1046) </td>
   <td style="text-align:center;"> (0.1046) </td>
   <td style="text-align:center;"> (0.0547) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 3++ </td>
   <td style="text-align:center;"> -3.7251 </td>
   <td style="text-align:center;"> -3.7251 </td>
   <td style="text-align:center;"> -3.7251 </td>
   <td style="text-align:center;"> -3.7036 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1777) </td>
   <td style="text-align:center;"> (0.1777) </td>
   <td style="text-align:center;"> (0.1777) </td>
   <td style="text-align:center;"> (0.0930) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Transit </td>
   <td style="text-align:center;"> -0.6709 </td>
   <td style="text-align:center;"> -0.6709 </td>
   <td style="text-align:center;"> -0.6709 </td>
   <td style="text-align:center;"> -0.6976 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1326) </td>
   <td style="text-align:center;"> (0.1326) </td>
   <td style="text-align:center;"> (0.1326) </td>
   <td style="text-align:center;"> (0.1304) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Bike </td>
   <td style="text-align:center;"> -2.3763 </td>
   <td style="text-align:center;"> -2.3763 </td>
   <td style="text-align:center;"> -2.3763 </td>
   <td style="text-align:center;"> -2.3981 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.3045) </td>
   <td style="text-align:center;"> (0.3045) </td>
   <td style="text-align:center;"> (0.3045) </td>
   <td style="text-align:center;"> (0.3038) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Walk </td>
   <td style="text-align:center;"> -0.2068 </td>
   <td style="text-align:center;"> -0.2068 </td>
   <td style="text-align:center;"> -0.2068 </td>
   <td style="text-align:center;"> -0.2292 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1941) </td>
   <td style="text-align:center;"> (0.1941) </td>
   <td style="text-align:center;"> (0.1941) </td>
   <td style="text-align:center;"> (0.1933) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tvtt </td>
   <td style="text-align:center;"> -0.0513 </td>
   <td style="text-align:center;"> -0.0513 </td>
   <td style="text-align:center;"> -0.0513 </td>
   <td style="text-align:center;"> -0.0513 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0031) </td>
   <td style="text-align:center;"> (0.0031) </td>
   <td style="text-align:center;"> (0.0031) </td>
   <td style="text-align:center;"> (0.0031) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cost </td>
   <td style="text-align:center;"> -0.0049 </td>
   <td style="text-align:center;"> -0.0049 </td>
   <td style="text-align:center;"> -0.0049 </td>
   <td style="text-align:center;"> -0.0049 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0002) </td>
   <td style="text-align:center;"> (0.0002) </td>
   <td style="text-align:center;"> (0.0002) </td>
   <td style="text-align:center;"> (0.0002) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 2 </td>
   <td style="text-align:center;"> -0.0022 </td>
   <td style="text-align:center;"> -0.0022 </td>
   <td style="text-align:center;"> -0.0022 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0016) </td>
   <td style="text-align:center;"> (0.0016) </td>
   <td style="text-align:center;"> (0.0016) </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 3++ </td>
   <td style="text-align:center;"> 0.0004 </td>
   <td style="text-align:center;"> 0.0004 </td>
   <td style="text-align:center;"> 0.0004 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0025) </td>
   <td style="text-align:center;"> (0.0025) </td>
   <td style="text-align:center;"> (0.0025) </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Transit </td>
   <td style="text-align:center;"> -0.0053 </td>
   <td style="text-align:center;"> -0.0053 </td>
   <td style="text-align:center;"> -0.0053 </td>
   <td style="text-align:center;"> -0.0049 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0018) </td>
   <td style="text-align:center;"> (0.0018) </td>
   <td style="text-align:center;"> (0.0018) </td>
   <td style="text-align:center;"> (0.0018) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Bike </td>
   <td style="text-align:center;"> -0.0128 </td>
   <td style="text-align:center;"> -0.0128 </td>
   <td style="text-align:center;"> -0.0128 </td>
   <td style="text-align:center;"> -0.0125 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0053) </td>
   <td style="text-align:center;"> (0.0053) </td>
   <td style="text-align:center;"> (0.0053) </td>
   <td style="text-align:center;"> (0.0053) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Walk </td>
   <td style="text-align:center;"> -0.0097 </td>
   <td style="text-align:center;"> -0.0097 </td>
   <td style="text-align:center;"> -0.0097 </td>
   <td style="text-align:center;"> -0.0093 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0030) </td>
   <td style="text-align:center;"> (0.0030) </td>
   <td style="text-align:center;"> (0.0030) </td>
   <td style="text-align:center;"> (0.0030) </td>
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
   <td style="text-align:center;"> 7276.4 </td>
   <td style="text-align:center;"> 7276.4 </td>
   <td style="text-align:center;"> 7276.4 </td>
   <td style="text-align:center;"> 7278.5 </td>
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
   <td style="text-align:center;"> -3626.186 </td>
   <td style="text-align:center;"> -3626.186 </td>
   <td style="text-align:center;"> -3626.186 </td>
   <td style="text-align:center;"> -3627.234 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho2 </td>
   <td style="text-align:center;"> 0.2534 </td>
   <td style="text-align:center;"> 0.2534 </td>
   <td style="text-align:center;"> 0.2534 </td>
   <td style="text-align:center;"> 0.2532 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho20 </td>
   <td style="text-align:center;"> 0.5976 </td>
   <td style="text-align:center;"> 0.5976 </td>
   <td style="text-align:center;"> 0.5976 </td>
   <td style="text-align:center;"> 0.5975 </td>
  </tr>
</tbody>
</table>

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:Table-6-2)Likelihood Ratio Tests between Models 1W, 2W, 3W and Base Model</caption>
 <thead>
  <tr>
   <th style="text-align:center;"> Model </th>
   <th style="text-align:center;"> loglik </th>
   <th style="text-align:center;"> lrtest </th>
   <th style="text-align:center;"> p_val </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> Model 1W </td>
   <td style="text-align:center;"> -3626.186 </td>
   <td style="text-align:center;"> 0.000000 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Model 2W </td>
   <td style="text-align:center;"> -3626.186 </td>
   <td style="text-align:center;"> 0.000000 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Model 3W </td>
   <td style="text-align:center;"> -3627.234 </td>
   <td style="text-align:center;"> 2.094772 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
</tbody>
</table>


### Different Specifications of Travel Time
The specification for travel time in the above models implies that the utility value of time is
equal for all the alternatives and between in-vehicle and out-of-vehicle time. However, we
expect travelers in non-motorized modes to be more sensitive to travel time than travelers in
motorized modes (since walking or biking is physically more demanding than traveling in a car)
and we expect that travelers are more sensitive to out-of-vehicle travel time (OVT) than to in 
vehicle travel time (IVT).

The estimation results for two specifications of travel time that relax these constraints are
reported with those for Model 1W in Table 6-3. Model 5W relaxes the time constraints in Model
1W by specifying distinct time variables for the motorized and non-motorized modes based on
our expectation that travelers are likely to be more sensitive to travel time by non-motorized
modes. Model 6W relaxes the constraint further by disaggregating the travel time for motorized
modes into distinct components for IVT and OVT. This specification allows the two
components of travel time for motorized travel to have different effects on utility with the
expectation that travelers are more sensitive to out-of-vehicle time than in-vehicle time.

The estimation results for Model 5W rejects the hypothesis of equal value of travel time
across modes implied in Model 1W and Model 6W rejects the hypothesis of equal value of in
and out of travel time for the motorized modes at a very high level of significance $(0.001)$. The
estimated parameters associated with travel time in Model 6W have the correct signs and the
magnitude of the parameters for OVT for motorized modes and for time for non-motorized
modes are larger in magnitude than the parameter for IVT, as expected; however, the parameter
for IVT is very small and not statistically significant. Further, the ratio of OVT to IVT for
motorized modes, 30 times, is far greater than expected. Nonetheless, since Model 6W rejects
the constraints imposed by both Models 1W and 5W at a very high level of significance, we
cannot discard this model without further exploration.

Another perspective on the suitability of these models can be obtained by calculating the
relative importance of each component of travel time and cost which gives us the implied value
of each component of time. The implied value of in-vehicle-time for motorized modes is computed 
for each model using the estimated motorized in-vehicle-time and cost parameters and
similarly for the other time components: 

\begin{equation}
$\displaystyle =  \text{Value of motorized IVTT (\$/hour)} = \frac{\beta_\text{motorized ivtt (1/min.)}}{\beta_{cost (1/cents)}} \times \frac{60 min./hour}{100 cents/\$} $
(\#eq:valueofivtt)
\end{equation}

The implied values of in- and out-of-vehicle times for motorized modes in Models 1W, 5W, and
6W are reported in Table 6-4. The values of motorized in-vehicle time and non-motorized time
are somewhat low but not unreasonable compared to the average wage rate of $21.20 per hour in
the region (1990 dollars); however, the value of in-vehicle time is unreasonably low.
Nevertheless, the likelihood ratio tests reject both Model 5W and Model 1W at very high levels
of significance. This raises doubt about the suitability of those models and suggests the need to
consider other specifications to evaluate the influence of travel time components on the utilities
of the different alternatives.

Two approaches are commonly taken to identify a specification which is not statistically
rejected by other models and has good behavioral relationships among variables. The first is to
examine a range of different specifications in an attempt to find one which is both behaviorally
sound and statistically supported. The other is to constrain the relationships between or among
parameter values to ratios which we are considered reasonable. The formulation of these
constraints is based on the judgment and prior empirical experience of the analyst. Therefore,
the use of such constraints imposes a responsibility on the analyst to provide a sound basis for
his/her decision. The advice of other more experienced analysts is often enlisted to expand
and/or support these judgments. 

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:Table-6-3-alternative-Specifications-of-Travel-Time)Estimation Results for Alternative Specifications of Travel Time</caption>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Model 1W </th>
   <th style="text-align:center;"> Model 5W </th>
   <th style="text-align:center;"> Model 6W </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 2 </td>
   <td style="text-align:center;"> -2.1780 </td>
   <td style="text-align:center;"> -2.2279 </td>
   <td style="text-align:center;"> -2.3961 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1046) </td>
   <td style="text-align:center;"> (0.1052) </td>
   <td style="text-align:center;"> (0.1075) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 3++ </td>
   <td style="text-align:center;"> -3.7251 </td>
   <td style="text-align:center;"> -3.7897 </td>
   <td style="text-align:center;"> -3.9957 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1777) </td>
   <td style="text-align:center;"> (0.1782) </td>
   <td style="text-align:center;"> (0.1802) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Transit </td>
   <td style="text-align:center;"> -0.6709 </td>
   <td style="text-align:center;"> -0.8532 </td>
   <td style="text-align:center;"> -0.4910 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1326) </td>
   <td style="text-align:center;"> (0.1392) </td>
   <td style="text-align:center;"> (0.1490) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Bike </td>
   <td style="text-align:center;"> -2.3763 </td>
   <td style="text-align:center;"> -1.8437 </td>
   <td style="text-align:center;"> -1.7186 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.3045) </td>
   <td style="text-align:center;"> (0.3258) </td>
   <td style="text-align:center;"> (0.3231) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Walk </td>
   <td style="text-align:center;"> -0.2068 </td>
   <td style="text-align:center;"> 0.4773 </td>
   <td style="text-align:center;"> 0.4096 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1941) </td>
   <td style="text-align:center;"> (0.2522) </td>
   <td style="text-align:center;"> (0.2533) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tvtt </td>
   <td style="text-align:center;"> -0.0513 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0031) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cost </td>
   <td style="text-align:center;"> -0.0049 </td>
   <td style="text-align:center;"> -0.0050 </td>
   <td style="text-align:center;"> -0.0048 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0002) </td>
   <td style="text-align:center;"> (0.0002) </td>
   <td style="text-align:center;"> (0.0002) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 2 </td>
   <td style="text-align:center;"> -0.0022 </td>
   <td style="text-align:center;"> -0.0021 </td>
   <td style="text-align:center;"> -0.0022 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0016) </td>
   <td style="text-align:center;"> (0.0016) </td>
   <td style="text-align:center;"> (0.0016) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 3++ </td>
   <td style="text-align:center;"> 0.0004 </td>
   <td style="text-align:center;"> 0.0004 </td>
   <td style="text-align:center;"> 0.0003 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0025) </td>
   <td style="text-align:center;"> (0.0025) </td>
   <td style="text-align:center;"> (0.0025) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Transit </td>
   <td style="text-align:center;"> -0.0053 </td>
   <td style="text-align:center;"> -0.0054 </td>
   <td style="text-align:center;"> -0.0057 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0018) </td>
   <td style="text-align:center;"> (0.0018) </td>
   <td style="text-align:center;"> (0.0019) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Bike </td>
   <td style="text-align:center;"> -0.0128 </td>
   <td style="text-align:center;"> -0.0125 </td>
   <td style="text-align:center;"> -0.0122 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0053) </td>
   <td style="text-align:center;"> (0.0053) </td>
   <td style="text-align:center;"> (0.0052) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Walk </td>
   <td style="text-align:center;"> -0.0097 </td>
   <td style="text-align:center;"> -0.0095 </td>
   <td style="text-align:center;"> -0.0093 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0030) </td>
   <td style="text-align:center;"> (0.0031) </td>
   <td style="text-align:center;"> (0.0031) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mot_tvtt </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.0431 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.0035) </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> nm_tvtt </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.0687 </td>
   <td style="text-align:center;"> -0.0632 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.0053) </td>
   <td style="text-align:center;"> (0.0054) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mot_ovtt </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.0759 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.0059) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mot_ivtt </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.0025 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.0062) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Num.Obs. </td>
   <td style="text-align:center;"> 5029 </td>
   <td style="text-align:center;"> 5029 </td>
   <td style="text-align:center;"> 5029 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> AIC </td>
   <td style="text-align:center;"> 7276.4 </td>
   <td style="text-align:center;"> 7259.0 </td>
   <td style="text-align:center;"> 7203.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BIC </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Log.Lik. </td>
   <td style="text-align:center;"> -3626.186 </td>
   <td style="text-align:center;"> -3616.494 </td>
   <td style="text-align:center;"> -3587.643 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho2 </td>
   <td style="text-align:center;"> 0.2534 </td>
   <td style="text-align:center;"> 0.2554 </td>
   <td style="text-align:center;"> 0.2614 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho20 </td>
   <td style="text-align:center;"> 0.5976 </td>
   <td style="text-align:center;"> 0.5986 </td>
   <td style="text-align:center;"> 0.6018 </td>
  </tr>
</tbody>
</table>
[^trumodel], [^valuesoftime]




<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:Vot-1-5-6)Implied Values of Time in Models 13W, 14W, and 15W</caption>
 <thead>
  <tr>
   <th style="text-align:center;"> Value of Time ($/hr) </th>
   <th style="text-align:center;"> Model 1W </th>
   <th style="text-align:center;"> Model 5W </th>
   <th style="text-align:center;"> Model 6W </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> Value of Non-Motorized Time </td>
   <td style="text-align:center;"> 6.26 </td>
   <td style="text-align:center;"> 8.24 </td>
   <td style="text-align:center;"> 7.91 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Value of Out-of-vehicle Time </td>
   <td style="text-align:center;"> 6.26 </td>
   <td style="text-align:center;"> 5.17 </td>
   <td style="text-align:center;"> 9.50 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Value of In-vehicle Time </td>
   <td style="text-align:center;"> 6.26 </td>
   <td style="text-align:center;"> 5.17 </td>
   <td style="text-align:center;"> 0.32 </td>
  </tr>
</tbody>
</table>

The primary shortcoming of the specification in Model 6W is that the estimated value of
IVT is unrealistically small. At least two alternatives can be considered for getting an improved
estimate of the value of out-of-vehicle time. One is to use an approach that has been effective in
other contexts; that is, to assume that the sensitivity of travelers to OVT diminishes with the trip
distance. The idea behind this is that travelers are more willing to tolerate higher out-of-vehicle
time for a long trip rather than for a short trip. We still expect that travelers will be more
sensitive to OVT than IVT for any travel distance. A formulation which ensures this result is to
include total travel time (the sum of in-vehicle and out-of-vehicle time) and out-of-vehicle time
divided by distance in place of in- and out-of-vehicle travel time. This specification, as shown
below, is consistent with our expectations provided that $\beta_1$ and $\beta_2$ are negative: 

\begin{equation}
\begin{split}
V_{m} &= \gamma_{0,m} + \beta_{1} \times TTT_{m} + \beta_{2} \times \Big(\frac{OVT_{m}}{Dist}\Big) + \ldots \\
&= \gamma_{0,m} + \beta_{1} \times (IVT_{m} + OVT_{m}) + \frac{\beta_{2}}{Dist} \times OVT_{m} + \ldots \\
&= \gamma_{0,m} + \beta_{1} \times IVT_{m} + \Big(\beta_{1} + \frac{\beta_{2}}{Dist}\Big) \times OVT_{m} + \ldots
\end{split}
(\#eq:IVTOVT)
\end{equation}

An alternative approach is to impose a constraint on the relative importance of OVT and IVT.
This is achieved by replacing the travel time variables in the modal utility equations with a
weighted travel time (WTT) variable defined as in-vehicle time plus the appropriate travel time
importance ratio (TIR) times out-of-vehicle time (IVT + TIR×OVT). The mechanics of how this
constraint works is illustrated as follows: 

\begin{equation}
\begin{split}
V_{m} &= \gamma_{0,m} + \beta_{1} \times IVT + (\beta_{1} \times TIR) \times OVT + \ldots \\
 &= \gamma_{0,m} + \beta_{1} \times (IVT + TIR \times OVT) + \ldots \\
 &= \gamma_{0,m} + \beta_{1} \times WTT + \ldots 
\end{split}
(\#eq:IVTTIROVT)
\end{equation}

so that the parameter for out-of-vehicle time is equal to the parameter for in-vehicle time
multiplied by the selected travel time ratio (TTR). In Models 8W and 9W, we use travel
importance ratios of 2.5 and 4.0, respectively. The estimation results for these models
compared to Model 6W are reported in Table 6-5. The parameter estimates obtained for the travel 
time, cost, and income variables in all four models have the correct signs and are statistically 
significant. Model 7W has substantially better goodness-of-fit than Models 6W, 8W and 9W. Since 
none of the other models are constrained versions of Model 7W, we use the non-nested hypothesis 
test (see [Section 5.7.3.2](#section5-7-3-2), Equation 5.21) to compare it with Models 6W, 8W, and 9W.
 
We illustrate the non-nested hypothesis test by applying it to the hypothesis that
Model 6W is the true model given that Model 7W has a higher $\overline{\rho}^{2}$. Since both models have the
same number of parameters, the term (K7-K6) drops out, and the equation becomes

\begin{equation}
$\displaystyle (Level \ of\ Rejection) = \Phi[-(-2(\overline{\rho_{7}}^{2}-\overline{\rho_{6}}^{2})\ l(0))^{1/2}]$
$\displaystyle = \Phi[-(-2(0.5129-0.5074)(-7309.6))^{1/2}]$
$\displaystyle = \Phi(-8.97)<< 0.001$
(\#eq:non-nestedhypothesistest)
\end{equation}

That is, the null hypothesis that Model 6W is the true model is rejected with significance much
greater than $0.001$. Models 8W and 9W are also rejected as the true model at an even higher
level of significance.


```r
sf_mlogit_trip_estimates <- sf_mlogit %>%
  mutate(
    TIR8 = (mot_ivtt + 2.4 * mot_ovtt),  
    TIR9 = (mot_ivtt + 4 * mot_ovtt), 
    ovtd = mot_ovtt/dist,
    scalemot = 2.4 * mot_ovtt,
    scalemot2 = 4 * mot_ovtt
    )
 
model_7w <- mlogit(chosen ~ mot_tvtt + nm_tvtt + ovtd + cost | hhinc, 
                   data = sf_mlogit_trip_estimates)
model_8w <- mlogit(chosen ~ nm_tvtt + TIR8  + cost | hhinc, 
                   data = sf_mlogit_trip_estimates)
model_9w <- mlogit(chosen ~ nm_tvtt + TIR9 + cost | hhinc, 
                   data = sf_mlogit_trip_estimates)
model_8a <- mlogit(chosen ~ nm_tvtt + (mot_ivtt + scalemot) + cost | hhinc,
                    data = sf_mlogit_trip_estimates)
model_9a <- mlogit(chosen ~ nm_tvtt + (mot_ivtt + scalemot2) + cost | hhinc, 
                   data = sf_mlogit_trip_estimates)

trip_1 <- list(
  "Model 6W" = model_6w,
  "Model 7W" = model_7w,
  "Model 8W" = model_8w,
  "Model 9W" = model_9w
)

modelsummary(
  trip_1, fmt = "%.4f",
  title = "Estimation Results for Additionaly Travel Time Specification Testing"
)
```

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:table6-5)Estimation Results for Additionaly Travel Time Specification Testing</caption>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Model 6W </th>
   <th style="text-align:center;"> Model 7W </th>
   <th style="text-align:center;"> Model 8W </th>
   <th style="text-align:center;"> Model 9W </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 2 </td>
   <td style="text-align:center;"> -2.3961 </td>
   <td style="text-align:center;"> -2.1519 </td>
   <td style="text-align:center;"> -2.2923 </td>
   <td style="text-align:center;"> -2.3302 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1075) </td>
   <td style="text-align:center;"> (0.1047) </td>
   <td style="text-align:center;"> (0.1042) </td>
   <td style="text-align:center;"> (0.1039) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 3++ </td>
   <td style="text-align:center;"> -3.9957 </td>
   <td style="text-align:center;"> -3.6362 </td>
   <td style="text-align:center;"> -3.8650 </td>
   <td style="text-align:center;"> -3.9120 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1802) </td>
   <td style="text-align:center;"> (0.1758) </td>
   <td style="text-align:center;"> (0.1772) </td>
   <td style="text-align:center;"> (0.1768) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Transit </td>
   <td style="text-align:center;"> -0.4910 </td>
   <td style="text-align:center;"> -0.0431 </td>
   <td style="text-align:center;"> -0.5897 </td>
   <td style="text-align:center;"> -0.5281 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1490) </td>
   <td style="text-align:center;"> (0.1597) </td>
   <td style="text-align:center;"> (0.1462) </td>
   <td style="text-align:center;"> (0.1479) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Bike </td>
   <td style="text-align:center;"> -1.7186 </td>
   <td style="text-align:center;"> -2.6862 </td>
   <td style="text-align:center;"> -1.8035 </td>
   <td style="text-align:center;"> -1.7741 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.3231) </td>
   <td style="text-align:center;"> (0.3337) </td>
   <td style="text-align:center;"> (0.3240) </td>
   <td style="text-align:center;"> (0.3232) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Walk </td>
   <td style="text-align:center;"> 0.4096 </td>
   <td style="text-align:center;"> -1.0226 </td>
   <td style="text-align:center;"> 0.4439 </td>
   <td style="text-align:center;"> 0.4297 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.2533) </td>
   <td style="text-align:center;"> (0.2920) </td>
   <td style="text-align:center;"> (0.2524) </td>
   <td style="text-align:center;"> (0.2526) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> nm_tvtt </td>
   <td style="text-align:center;"> -0.0632 </td>
   <td style="text-align:center;"> -0.0475 </td>
   <td style="text-align:center;"> -0.0664 </td>
   <td style="text-align:center;"> -0.0652 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0054) </td>
   <td style="text-align:center;"> (0.0055) </td>
   <td style="text-align:center;"> (0.0053) </td>
   <td style="text-align:center;"> (0.0053) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mot_ovtt </td>
   <td style="text-align:center;"> -0.0759 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0059) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mot_ivtt </td>
   <td style="text-align:center;"> -0.0025 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0062) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cost </td>
   <td style="text-align:center;"> -0.0048 </td>
   <td style="text-align:center;"> -0.0041 </td>
   <td style="text-align:center;"> -0.0049 </td>
   <td style="text-align:center;"> -0.0048 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0002) </td>
   <td style="text-align:center;"> (0.0002) </td>
   <td style="text-align:center;"> (0.0002) </td>
   <td style="text-align:center;"> (0.0002) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 2 </td>
   <td style="text-align:center;"> -0.0022 </td>
   <td style="text-align:center;"> -0.0020 </td>
   <td style="text-align:center;"> -0.0022 </td>
   <td style="text-align:center;"> -0.0022 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0016) </td>
   <td style="text-align:center;"> (0.0015) </td>
   <td style="text-align:center;"> (0.0016) </td>
   <td style="text-align:center;"> (0.0016) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 3++ </td>
   <td style="text-align:center;"> 0.0003 </td>
   <td style="text-align:center;"> 0.0006 </td>
   <td style="text-align:center;"> 0.0004 </td>
   <td style="text-align:center;"> 0.0003 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0025) </td>
   <td style="text-align:center;"> (0.0025) </td>
   <td style="text-align:center;"> (0.0025) </td>
   <td style="text-align:center;"> (0.0025) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Transit </td>
   <td style="text-align:center;"> -0.0057 </td>
   <td style="text-align:center;"> -0.0072 </td>
   <td style="text-align:center;"> -0.0055 </td>
   <td style="text-align:center;"> -0.0055 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0019) </td>
   <td style="text-align:center;"> (0.0019) </td>
   <td style="text-align:center;"> (0.0018) </td>
   <td style="text-align:center;"> (0.0018) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Bike </td>
   <td style="text-align:center;"> -0.0122 </td>
   <td style="text-align:center;"> -0.0119 </td>
   <td style="text-align:center;"> -0.0124 </td>
   <td style="text-align:center;"> -0.0123 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0052) </td>
   <td style="text-align:center;"> (0.0052) </td>
   <td style="text-align:center;"> (0.0053) </td>
   <td style="text-align:center;"> (0.0052) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Walk </td>
   <td style="text-align:center;"> -0.0093 </td>
   <td style="text-align:center;"> -0.0082 </td>
   <td style="text-align:center;"> -0.0095 </td>
   <td style="text-align:center;"> -0.0094 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0031) </td>
   <td style="text-align:center;"> (0.0032) </td>
   <td style="text-align:center;"> (0.0031) </td>
   <td style="text-align:center;"> (0.0031) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mot_tvtt </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.0415 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.0035) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ovtd </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.1813 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.0179) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TIR8 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.0262 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.0019) </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TIR9 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.0173 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.0013) </td>
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
   <td style="text-align:center;"> 7203.3 </td>
   <td style="text-align:center;"> 7121.8 </td>
   <td style="text-align:center;"> 7216.8 </td>
   <td style="text-align:center;"> 7207.0 </td>
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
   <td style="text-align:center;"> -3587.643 </td>
   <td style="text-align:center;"> -3546.891 </td>
   <td style="text-align:center;"> -3595.381 </td>
   <td style="text-align:center;"> -3590.518 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho2 </td>
   <td style="text-align:center;"> 0.2614 </td>
   <td style="text-align:center;"> 0.2698 </td>
   <td style="text-align:center;"> 0.2598 </td>
   <td style="text-align:center;"> 0.2608 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho20 </td>
   <td style="text-align:center;"> 0.6018 </td>
   <td style="text-align:center;"> 0.6064 </td>
   <td style="text-align:center;"> 0.6010 </td>
   <td style="text-align:center;"> 0.6015 </td>
  </tr>
</tbody>
</table>

Before adopting Model 7W, it is a good idea to evaluate and interpret the relative
importance of in-vehicle and out-of-vehicle time and between each component of time and cost.
Despite the difference in the specification, this analysis is undertaken the same way as earlier;
that is, the parameters for time is divided by the parameter for cost to obtain the values of time.
The values of IVT and OVT in cents-per-minute (and dollars-per-hour) are shown in Table 6-6
as a function of distance. The time values are obtained as described earlier by dividing each of
the time parameters (in utils-per-minute) by the cost parameter in utils per cent. For example,
the values for Model 7W are:

Value of IVTT $= \frac{\beta_{mot\ tvtt}}{\beta_{cost}} = \frac{-0.0415}{-0.0041}$
              = 10.1 cents/min = $6.07/hr

Value of OVT (5 Mile Trip) $= \frac{\beta_{mot\ tvtt}+ \frac{\beta_{OVT/Dist}}{Dist}}{\beta_{cost}}$
                           $= \frac{-0.0415+ \frac{-0.1812}{5}}{-0.0041}$
                            = 19.0 cents/min = $11.38/hr
                            
These values of time are fixed for IVT but vary with distance for OVT[^costbyinc] as reported in Table 6-6
for Model 7W. The corresponding values of time for Models 6W, 8W and 9W are shown in
Table 6-7.


<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:model7w_vot)Model 7W Implied Values of Time as a Function of Trip Distance</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> distance </th>
   <th style="text-align:right;"> Value of Motorized Out-of-Vehicle Time </th>
   <th style="text-align:right;"> Value of Motorized In-Vehicle Time </th>
   <th style="text-align:right;"> Value of Non-Motorized Time </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 10.10156 </td>
   <td style="text-align:right;"> 11.53997 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 10.10156 </td>
   <td style="text-align:right;"> 11.53997 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 10.10156 </td>
   <td style="text-align:right;"> 11.53997 </td>
  </tr>
</tbody>
</table>

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:Table 6-7 Implied Values of Time in Models 6W, 8W, Model 9W)Implied Values of Time in Models 6W, 8W, and 9W</caption>
 <thead>
  <tr>
   <th style="text-align:center;"> Value of Time ($/hr) </th>
   <th style="text-align:center;"> Model 6W </th>
   <th style="text-align:center;"> Model 8W </th>
   <th style="text-align:center;"> Model 9W </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> Value of Out-of-vehicle Time </td>
   <td style="text-align:center;"> 9.50 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Value of In-vehicle Time </td>
   <td style="text-align:center;"> 0.32 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
  </tr>
</tbody>
</table>

The prevailing wage rate in the San Francisco Bay Area is $21.20 per hour[^refsfmodel]. In
comparison, the values of in-vehicle time implied by Models 6W, 8W, and 9W are very low and
the values of out of vehicle time are somewhat low. Model 7W produces higher, but still low,
values of time. Finally, we can examine the ratio of time values of OVT relative to IVT for all
four models as shown in Figure 6.1. The ratio for Model 6W is clearly unacceptable. Those for
Models 7W, 8W and 9W are more reasonable.


```r
vottable <- tibble(
"Value of Time ($/hr)" = c("Value of Out-of-vehicle Time", "Value of In-vehicle Time"),
"Model 6W" = round(c(VOTsimple(model_6w, "mot_ovtt", "cost"), VOTsimple(model_6w, "mot_ivtt", "cost")),2),

"Model 7W" = round(c(VOTsimple(model_7w, "mot_tvtt", "cost"), VOTsimple(model_7w, "mot_tvtt", "cost")),2),

"Model 8W" = round(c(VOTsimple(model_8a, "scalemot", "cost"), VOTsimple(model_8a, "mot_ivtt", "cost")),2),

"Model 9W" = round(c(VOTsimple(model_9a, "scalemot2", "cost"), VOTsimple(model_9a, "mot_ivtt", "cost")),2)
) 

model_6wa = as.numeric(vottable[1,"Model 6W"]/vottable[2,"Model 6W"])
model_7wa = as.numeric(vottable[1,"Model 7W"]/vottable[2,"Model 7W"])
model_8wa = as.numeric(vottable[1,"Model 8W"]/vottable[2,"Model 8W"])
model_9wa = as.numeric(vottable[1,"Model 9W"]/vottable[2,"Model 9W"])

tibble(
  distance = .8:10,
  model6 = model_6wa,
  model7 = model_7wa/distance,
  model8 = model_8wa,
  model9 = model_9wa
) %>%
  gather(model, vot, -distance) %>%
  ggplot(aes(x = distance, y = vot, color = model)) + 
    geom_line()
```

<img src="06-specification_files/figure-html/figure6-1-1.png" width="672" />

The selection of a preferred travel time specification among the four alternative specifications
tested is relatively straightforward in this case. Model 7W outperforms the other models in all
the evaluations undertaken; it has the best goodness-of-fit, the most intuitive relationship
between the IVT and OVT variables and the most acceptable values of time[^imposedconstraints]. Consequently,
Model 7W is our preferred travel time specification. We can still consider imposing a constraint
between the time and cost variables to force the value of time to more reasonable levels.
However, we defer this until we explore other specification improvements. 

### Including Additinal Decision Maker Related Variables
There are strong theoretical and empirical reasons to expect that a variety of decision maker
related variables such as income, car availability, residential location, number of workers in the
household and others, influence workers’ choice of travel mode. The models reported to this
point include income as the only decision maker related explanatory variable. To the extent that
these variables influence the mode choice decision of travelers, their inclusion in the model will
increase the explanatory power and predictive accuracy of the model. 

There are two general approaches to including decision maker related variables in
models. One is to include such variables as specific to each alternative (except for one base or
reference alternative) to indicate the extent to which changes in the variable value will increase
or decrease the utility of the mode to that traveler (relative to the reference alternative). The
other is to include such variables as interactions with mode related characteristics. For example,
dividing cost by income to reflect the decreasing importance of cost with increasing annual
income. The inclusion of decision maker related variables as alternative specific variables is
demonstrated in this section. Similar treatment of trip context variables is considered in [Section 6.2.4](#section6-2-4). Interactions with mode characteristics are demonstrated in [Section 6.2.5](#section6-2-5).

We consider number of automobiles in the household, the number of autos divided by the
number of household workers and the number of autos divided by the number of persons of
driving age in the household. Since these variables are constant across all alternatives, they must
be included as distinct variables for each alternative (except for the reference alternative). This
is considered a full set of alternative specific variables. The estimation results for these
specifications and Model 7W are reported in Table 6-8.

These three new models have much better goodness-of-fit than Model 7W. Each model
rejects Model 7W as the true model at a very high level of significance. The parameters for
alternative specific automobile availability variables in all the three models have the expected
signs, negative relative to drive alone, with the exception of the shared ride 3+ variable in Model
10W which is not significant. Further, the signs and magnitude of the parameters for time, cost,
and income are stable across the models. Finally, Models 11W and 12W which include cars-perworker and 
cars-per-number-of-adults, respectively, reject Model 10W as the true model.

Overall, Models 11W and 12W are superior to the other two models in terms of
behavioral appeal, they provide an indication of automobile availability, and goodness of fit,
they statistically reject Models 7W and 10W statistical fit. Model 11W has slightly better
goodness-of-fit than Model 12W but the difference is so small that the non-nested hypothesis test
is not able to distinguish between the two models. Therefore, selection of a preferred model is
primarily a matter of judgment. We select Model 11W but selection of Model 12W would be
equally appropriate.

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:Table 6-8 Estimation for Auto Availability)Estimation Results for Auto Availiability Specification Testing</caption>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Model 7W </th>
   <th style="text-align:center;"> Model 10W </th>
   <th style="text-align:center;"> Model 11W </th>
   <th style="text-align:center;"> Model 12W </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 2 </td>
   <td style="text-align:center;"> -2.1519 </td>
   <td style="text-align:center;"> -2.0374 </td>
   <td style="text-align:center;"> -1.5651 </td>
   <td style="text-align:center;"> -1.5105 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1047) </td>
   <td style="text-align:center;"> (0.1246) </td>
   <td style="text-align:center;"> (0.1364) </td>
   <td style="text-align:center;"> (0.1441) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 3++ </td>
   <td style="text-align:center;"> -3.6362 </td>
   <td style="text-align:center;"> -3.7004 </td>
   <td style="text-align:center;"> -3.2375 </td>
   <td style="text-align:center;"> -3.1128 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1758) </td>
   <td style="text-align:center;"> (0.2073) </td>
   <td style="text-align:center;"> (0.2195) </td>
   <td style="text-align:center;"> (0.2315) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Transit </td>
   <td style="text-align:center;"> -0.0431 </td>
   <td style="text-align:center;"> 0.5734 </td>
   <td style="text-align:center;"> 0.9262 </td>
   <td style="text-align:center;"> 1.0493 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1597) </td>
   <td style="text-align:center;"> (0.1807) </td>
   <td style="text-align:center;"> (0.1924) </td>
   <td style="text-align:center;"> (0.1976) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Bike </td>
   <td style="text-align:center;"> -2.6862 </td>
   <td style="text-align:center;"> -2.2196 </td>
   <td style="text-align:center;"> -1.8303 </td>
   <td style="text-align:center;"> -1.9617 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.3337) </td>
   <td style="text-align:center;"> (0.3807) </td>
   <td style="text-align:center;"> (0.4082) </td>
   <td style="text-align:center;"> (0.4159) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Walk </td>
   <td style="text-align:center;"> -1.0226 </td>
   <td style="text-align:center;"> -0.4404 </td>
   <td style="text-align:center;"> -0.2371 </td>
   <td style="text-align:center;"> -0.2165 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.2920) </td>
   <td style="text-align:center;"> (0.3315) </td>
   <td style="text-align:center;"> (0.3410) </td>
   <td style="text-align:center;"> (0.3453) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mot_tvtt </td>
   <td style="text-align:center;"> -0.0415 </td>
   <td style="text-align:center;"> -0.0378 </td>
   <td style="text-align:center;"> -0.0384 </td>
   <td style="text-align:center;"> -0.0380 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0035) </td>
   <td style="text-align:center;"> (0.0036) </td>
   <td style="text-align:center;"> (0.0036) </td>
   <td style="text-align:center;"> (0.0036) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> nm_tvtt </td>
   <td style="text-align:center;"> -0.0475 </td>
   <td style="text-align:center;"> -0.0475 </td>
   <td style="text-align:center;"> -0.0470 </td>
   <td style="text-align:center;"> -0.0466 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0055) </td>
   <td style="text-align:center;"> (0.0057) </td>
   <td style="text-align:center;"> (0.0056) </td>
   <td style="text-align:center;"> (0.0056) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mot_ovttbydist </td>
   <td style="text-align:center;"> -0.1813 </td>
   <td style="text-align:center;"> -0.1786 </td>
   <td style="text-align:center;"> -0.1814 </td>
   <td style="text-align:center;"> -0.1849 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0179) </td>
   <td style="text-align:center;"> (0.0185) </td>
   <td style="text-align:center;"> (0.0185) </td>
   <td style="text-align:center;"> (0.0187) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cost </td>
   <td style="text-align:center;"> -0.0041 </td>
   <td style="text-align:center;"> -0.0041 </td>
   <td style="text-align:center;"> -0.0042 </td>
   <td style="text-align:center;"> -0.0042 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0002) </td>
   <td style="text-align:center;"> (0.0002) </td>
   <td style="text-align:center;"> (0.0002) </td>
   <td style="text-align:center;"> (0.0002) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 2 </td>
   <td style="text-align:center;"> -0.0020 </td>
   <td style="text-align:center;"> -0.0024 </td>
   <td style="text-align:center;"> -0.0022 </td>
   <td style="text-align:center;"> -0.0019 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0015) </td>
   <td style="text-align:center;"> (0.0016) </td>
   <td style="text-align:center;"> (0.0016) </td>
   <td style="text-align:center;"> (0.0016) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 3++ </td>
   <td style="text-align:center;"> 0.0006 </td>
   <td style="text-align:center;"> -0.0007 </td>
   <td style="text-align:center;"> 0.0001 </td>
   <td style="text-align:center;"> 0.0005 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0025) </td>
   <td style="text-align:center;"> (0.0026) </td>
   <td style="text-align:center;"> (0.0025) </td>
   <td style="text-align:center;"> (0.0025) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Transit </td>
   <td style="text-align:center;"> -0.0072 </td>
   <td style="text-align:center;"> -0.0013 </td>
   <td style="text-align:center;"> -0.0060 </td>
   <td style="text-align:center;"> -0.0046 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0019) </td>
   <td style="text-align:center;"> (0.0020) </td>
   <td style="text-align:center;"> (0.0020) </td>
   <td style="text-align:center;"> (0.0020) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Bike </td>
   <td style="text-align:center;"> -0.0119 </td>
   <td style="text-align:center;"> -0.0095 </td>
   <td style="text-align:center;"> -0.0116 </td>
   <td style="text-align:center;"> -0.0117 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0052) </td>
   <td style="text-align:center;"> (0.0054) </td>
   <td style="text-align:center;"> (0.0053) </td>
   <td style="text-align:center;"> (0.0053) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Walk </td>
   <td style="text-align:center;"> -0.0082 </td>
   <td style="text-align:center;"> -0.0042 </td>
   <td style="text-align:center;"> -0.0080 </td>
   <td style="text-align:center;"> -0.0077 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0032) </td>
   <td style="text-align:center;"> (0.0034) </td>
   <td style="text-align:center;"> (0.0032) </td>
   <td style="text-align:center;"> (0.0033) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> numveh × Share ride 2 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.0325 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.0393) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> numveh × Share ride 3++ </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.0655 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.0586) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> numveh × Transit </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.5544 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.0689) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> numveh × Bike </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.2293 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.1316) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> numveh × Walk </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.3655 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.0995) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Share ride 2 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.4298 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.0767) </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Share ride 3++ </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.2732 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.1129) </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Transit </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.9903 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.1157) </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Bike </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.6731 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.2515) </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Walk </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.6286 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.1627) </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> autoperad × Share ride 2 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.5875 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.1088) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> autoperad × Share ride 3++ </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.4652 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.1688) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> autoperad × Transit </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -1.4099 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.1546) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> autoperad × Bike </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.6426 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.3027) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> autoperad × Walk </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.7943 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.2082) </td>
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
   <td style="text-align:center;"> 7121.8 </td>
   <td style="text-align:center;"> 7041.0 </td>
   <td style="text-align:center;"> 7015.8 </td>
   <td style="text-align:center;"> 7018.0 </td>
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
   <td style="text-align:center;"> -3546.891 </td>
   <td style="text-align:center;"> -3501.483 </td>
   <td style="text-align:center;"> -3488.886 </td>
   <td style="text-align:center;"> -3490.002 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho2 </td>
   <td style="text-align:center;"> 0.2698 </td>
   <td style="text-align:center;"> 0.2791 </td>
   <td style="text-align:center;"> 0.2817 </td>
   <td style="text-align:center;"> 0.2815 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho20 </td>
   <td style="text-align:center;"> 0.6064 </td>
   <td style="text-align:center;"> 0.6114 </td>
   <td style="text-align:center;"> 0.6128 </td>
   <td style="text-align:center;"> 0.6127 </td>
  </tr>
</tbody>
</table>

### Including Trip Context variables {#section6-2-4}
The models considered to this point include variables that describe the attributes of alternatives,
modes, and the characteristics of decision-makers (the work commuters). The mode choice decision also 
is influenced by variables that describe the context in which the trip is made. For
example, a work trip to the regional central business district (CBD) is more likely to be made by
transit than an otherwise similar trip to a suburban work place because the CBD is generally
well-served by transit, has more opportunities to make additional stops by walking and is less
auto friendly due to congestion and limited and expensive parking. This suggests that the model
specification can be enhanced by including variables related to the context of the trip, such as
destination zone location.

We consider two distinct variables to describe the trip destination context. One is a
dummy variable which indicates whether the destination zone (workplace) is located in the
CBD; the other is the employment density of different workplace destinations. The CBD
variable implies an abrupt increase in the likelihood of using public transit at the CBD boundary.
The density variable implies a continuous increase in the likelihood of using public transit with
increasing workplace density. A third option is to include both variables in the model. There is
disagreement about whether to include such combinations of variables since they both represent
the same underlying phenomenon: increasing transit use with increasing density of
development. There is no firm rule about this point; each case must be evaluated on its merits
based on statistical tests and reasonableness of the estimation results. As with the addition of
characteristics of the traveler, we introduce each variable as a full set of alternative specific
variables, each of which represents the effect of a change in that variable on the utility of the
alternative relative to the reference alternative (drive alone). Model 13W adds the alternative
specific CBD dummy variables to the variables in Model 11W. Model 14W adds the alternative
specific employment density variables and Model 15W adds both. Estimation results for these
specifications and Model 11W are reported in Table 6-9. 



<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:trip-context-table)Estimation Results for Models with Trip Context Variables</caption>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Model 11W </th>
   <th style="text-align:center;"> Model 13W </th>
   <th style="text-align:center;"> Model 14W </th>
   <th style="text-align:center;"> Model 15W </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 2 </td>
   <td style="text-align:center;"> -1.5651 (0.1364) </td>
   <td style="text-align:center;"> -1.6134 (0.1403) </td>
   <td style="text-align:center;"> -1.5818 (0.1370) </td>
   <td style="text-align:center;"> -1.6192 (0.1403) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 3++ </td>
   <td style="text-align:center;"> -3.2375 (0.2195) </td>
   <td style="text-align:center;"> -3.6071 (0.2333) </td>
   <td style="text-align:center;"> -3.2913 (0.2219) </td>
   <td style="text-align:center;"> -3.6182 (0.2333) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Transit </td>
   <td style="text-align:center;"> 0.9262 (0.1924) </td>
   <td style="text-align:center;"> -0.2034 (0.2426) </td>
   <td style="text-align:center;"> 0.4180 (0.2090) </td>
   <td style="text-align:center;"> -0.4729 (0.2512) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Bike </td>
   <td style="text-align:center;"> -1.8303 (0.4082) </td>
   <td style="text-align:center;"> -1.6502 (0.4284) </td>
   <td style="text-align:center;"> -1.5966 (0.4170) </td>
   <td style="text-align:center;"> -1.5145 (0.4296) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Walk </td>
   <td style="text-align:center;"> -0.2371 (0.3410) </td>
   <td style="text-align:center;"> 0.0845 (0.3476) </td>
   <td style="text-align:center;"> -0.0399 (0.3442) </td>
   <td style="text-align:center;"> 0.2108 (0.3483) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mot_tvtt </td>
   <td style="text-align:center;"> -0.0384 (0.0036) </td>
   <td style="text-align:center;"> -0.0286 (0.0038) </td>
   <td style="text-align:center;"> -0.0299 (0.0038) </td>
   <td style="text-align:center;"> -0.0231 (0.0039) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> nm_tvtt </td>
   <td style="text-align:center;"> -0.0470 (0.0056) </td>
   <td style="text-align:center;"> -0.0464 (0.0057) </td>
   <td style="text-align:center;"> -0.0459 (0.0057) </td>
   <td style="text-align:center;"> -0.0467 (0.0058) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mot_ovttbydist </td>
   <td style="text-align:center;"> -0.1814 (0.0185) </td>
   <td style="text-align:center;"> -0.1501 (0.0197) </td>
   <td style="text-align:center;"> -0.1575 (0.0190) </td>
   <td style="text-align:center;"> -0.1324 (0.0197) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cost </td>
   <td style="text-align:center;"> -0.0042 (0.0002) </td>
   <td style="text-align:center;"> -0.0033 (0.0003) </td>
   <td style="text-align:center;"> -0.0029 (0.0003) </td>
   <td style="text-align:center;"> -0.0024 (0.0003) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 2 </td>
   <td style="text-align:center;"> -0.0022 (0.0016) </td>
   <td style="text-align:center;"> -0.0022 (0.0016) </td>
   <td style="text-align:center;"> -0.0022 (0.0016) </td>
   <td style="text-align:center;"> -0.0022 (0.0016) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 3++ </td>
   <td style="text-align:center;"> 0.0001 (0.0025) </td>
   <td style="text-align:center;"> -0.0004 (0.0025) </td>
   <td style="text-align:center;"> -0.0003 (0.0025) </td>
   <td style="text-align:center;"> -0.0005 (0.0025) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Transit </td>
   <td style="text-align:center;"> -0.0060 (0.0020) </td>
   <td style="text-align:center;"> -0.0061 (0.0020) </td>
   <td style="text-align:center;"> -0.0070 (0.0020) </td>
   <td style="text-align:center;"> -0.0070 (0.0021) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Bike </td>
   <td style="text-align:center;"> -0.0116 (0.0053) </td>
   <td style="text-align:center;"> -0.0111 (0.0052) </td>
   <td style="text-align:center;"> -0.0112 (0.0053) </td>
   <td style="text-align:center;"> -0.0109 (0.0053) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Walk </td>
   <td style="text-align:center;"> -0.0080 (0.0032) </td>
   <td style="text-align:center;"> -0.0078 (0.0032) </td>
   <td style="text-align:center;"> -0.0079 (0.0032) </td>
   <td style="text-align:center;"> -0.0081 (0.0032) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Share ride 2 </td>
   <td style="text-align:center;"> -0.4298 (0.0767) </td>
   <td style="text-align:center;"> -0.4129 (0.0769) </td>
   <td style="text-align:center;"> -0.4044 (0.0764) </td>
   <td style="text-align:center;"> -0.3988 (0.0769) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Share ride 3++ </td>
   <td style="text-align:center;"> -0.2732 (0.1129) </td>
   <td style="text-align:center;"> -0.2175 (0.1114) </td>
   <td style="text-align:center;"> -0.2423 (0.1133) </td>
   <td style="text-align:center;"> -0.1880 (0.1111) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Transit </td>
   <td style="text-align:center;"> -0.9903 (0.1157) </td>
   <td style="text-align:center;"> -0.9113 (0.1148) </td>
   <td style="text-align:center;"> -0.9956 (0.1190) </td>
   <td style="text-align:center;"> -0.9303 (0.1179) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Bike </td>
   <td style="text-align:center;"> -0.6731 (0.2515) </td>
   <td style="text-align:center;"> -0.6982 (0.2561) </td>
   <td style="text-align:center;"> -0.7137 (0.2585) </td>
   <td style="text-align:center;"> -0.7151 (0.2590) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Walk </td>
   <td style="text-align:center;"> -0.6286 (0.1627) </td>
   <td style="text-align:center;"> -0.7197 (0.1682) </td>
   <td style="text-align:center;"> -0.6815 (0.1671) </td>
   <td style="text-align:center;"> -0.7276 (0.1694) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Share ride 2 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.2571 (0.1100) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.2037 (0.1246) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Share ride 3++ </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 1.0520 (0.1725) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 1.0161 (0.1926) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Transit </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 1.3556 (0.1613) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 1.2037 (0.1678) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Bike </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.3755 (0.3214) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.4609 (0.3601) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Walk </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.1740 (0.2252) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.1074 (0.2508) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Share ride 2 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.0011 (0.0004) </td>
   <td style="text-align:center;"> 0.0010 (0.0004) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Share ride 3++ </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.0022 (0.0004) </td>
   <td style="text-align:center;"> 0.0013 (0.0005) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Transit </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.0027 (0.0004) </td>
   <td style="text-align:center;"> 0.0021 (0.0004) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Bike </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.0011 (0.0011) </td>
   <td style="text-align:center;"> 0.0008 (0.0012) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Walk </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.0015 (0.0007) </td>
   <td style="text-align:center;"> 0.0018 (0.0008) </td>
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
   <td style="text-align:center;"> 7015.8 </td>
   <td style="text-align:center;"> 6928.9 </td>
   <td style="text-align:center;"> 6968.9 </td>
   <td style="text-align:center;"> 6906.7 </td>
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
   <td style="text-align:center;"> -3488.886 </td>
   <td style="text-align:center;"> -3440.445 </td>
   <td style="text-align:center;"> -3460.438 </td>
   <td style="text-align:center;"> -3424.361 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho2 </td>
   <td style="text-align:center;"> 0.2817 </td>
   <td style="text-align:center;"> 0.2917 </td>
   <td style="text-align:center;"> 0.2876 </td>
   <td style="text-align:center;"> 0.2950 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho20 </td>
   <td style="text-align:center;"> 0.6128 </td>
   <td style="text-align:center;"> 0.6182 </td>
   <td style="text-align:center;"> 0.6160 </td>
   <td style="text-align:center;"> 0.6200 </td>
  </tr>
</tbody>
</table>

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:Vot-13-14-15)Implied Values of Time in Models 13W, 14W, and 15W</caption>
 <thead>
  <tr>
   <th style="text-align:center;"> Value of Time ($/hr) </th>
   <th style="text-align:center;"> Model 13W </th>
   <th style="text-align:center;"> Model 14W </th>
   <th style="text-align:center;"> Model 15W </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> Value of Motorized IVT </td>
   <td style="text-align:center;"> 5.23 </td>
   <td style="text-align:center;"> 6.22 </td>
   <td style="text-align:center;"> 5.88 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Value of Motorized OVT (10 mile trip) </td>
   <td style="text-align:center;"> 7.97 </td>
   <td style="text-align:center;"> 9.50 </td>
   <td style="text-align:center;"> 9.25 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Value of Motorized OVT (20 mile trip) </td>
   <td style="text-align:center;"> 6.60 </td>
   <td style="text-align:center;"> 7.86 </td>
   <td style="text-align:center;"> 7.57 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Value of Non-Motorized Time </td>
   <td style="text-align:center;"> 8.48 </td>
   <td style="text-align:center;"> 9.54 </td>
   <td style="text-align:center;"> 11.89 </td>
  </tr>
</tbody>
</table>


Each of the new Models (13W, 14W and 15W) significantly reject Model 11W as the
true model at a very high level of significance. Further, the parameters for all of the alternative
specific CBD dummy and employment density variables have a positive sign, implying that all
else being equal, an individual is less likely to choose drive alone mode for trips destined to a
CBD and/or high employment density zones, as expected.

Since Models 13W and 14W are restricted versions of Model 15W, we can use the loglikelihood test 
which rejects the hypothesis that each of these models is the true model.
Therefore, purely on statistical grounds, Model 15W is preferred over Models 13W and 14W.
However, this improvement in statistical fit comes at the cost of increased model complexity,
and it may be appropriate to adopt Model 13W or 14W, sacrificing statistical fit in favor of
parsimony[^parsimony]. For now, we choose Model 15W as the preferred model for its stronger statistical
results, but we will return to the issue of model complexity. 

### Interactions between Trip maker and/or Context Characteristics and Mode Attributes {#section6-2-5}
Another approach to the inclusion of trip maker or context characteristics is through interactions
with mode attributes. The most common example of this approach is to take account of the
expectation that low-income travelers will be more sensitive to travel cost than high-income
travelers by using cost divided by income in place of cost as an explanatory variable. Such a
specification implies that the importance of cost in mode choice diminishes with increasing 
household income. Table 6-11 portrays the estimation results for two models that differ only in
how they represent cost; Model 15W includes travel cost while Model 16W includes travel cost
divided by income.

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:income_interaction)Estimation Results for Models with Trip Context Variables</caption>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Model 15W </th>
   <th style="text-align:center;"> Model 16W </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 2 </td>
   <td style="text-align:center;"> -1.6192 (0.1403) </td>
   <td style="text-align:center;"> -1.6976 (0.1419) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 3++ </td>
   <td style="text-align:center;"> -3.6182 (0.2333) </td>
   <td style="text-align:center;"> -3.7733 (0.2356) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Transit </td>
   <td style="text-align:center;"> -0.4729 (0.2512) </td>
   <td style="text-align:center;"> -0.6930 (0.2496) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Bike </td>
   <td style="text-align:center;"> -1.5145 (0.4296) </td>
   <td style="text-align:center;"> -1.6233 (0.4290) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Walk </td>
   <td style="text-align:center;"> 0.2108 (0.3483) </td>
   <td style="text-align:center;"> 0.0751 (0.3492) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mot_tvtt </td>
   <td style="text-align:center;"> -0.0231 (0.0039) </td>
   <td style="text-align:center;"> -0.0202 (0.0038) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> nm_tvtt </td>
   <td style="text-align:center;"> -0.0467 (0.0058) </td>
   <td style="text-align:center;"> -0.0455 (0.0058) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mot_ovttbydist </td>
   <td style="text-align:center;"> -0.1324 (0.0197) </td>
   <td style="text-align:center;"> -0.1326 (0.0196) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cost </td>
   <td style="text-align:center;"> -0.0024 (0.0003) </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 2 </td>
   <td style="text-align:center;"> -0.0022 (0.0016) </td>
   <td style="text-align:center;"> -0.0006 (0.0016) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 3++ </td>
   <td style="text-align:center;"> -0.0005 (0.0025) </td>
   <td style="text-align:center;"> 0.0023 (0.0025) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Transit </td>
   <td style="text-align:center;"> -0.0070 (0.0021) </td>
   <td style="text-align:center;"> -0.0052 (0.0021) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Bike </td>
   <td style="text-align:center;"> -0.0109 (0.0053) </td>
   <td style="text-align:center;"> -0.0086 (0.0052) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Walk </td>
   <td style="text-align:center;"> -0.0081 (0.0032) </td>
   <td style="text-align:center;"> -0.0060 (0.0032) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Share ride 2 </td>
   <td style="text-align:center;"> -0.3988 (0.0769) </td>
   <td style="text-align:center;"> -0.3780 (0.0765) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Share ride 3++ </td>
   <td style="text-align:center;"> -0.1880 (0.1111) </td>
   <td style="text-align:center;"> -0.1475 (0.1101) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Transit </td>
   <td style="text-align:center;"> -0.9303 (0.1179) </td>
   <td style="text-align:center;"> -0.9400 (0.1185) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Bike </td>
   <td style="text-align:center;"> -0.7151 (0.2590) </td>
   <td style="text-align:center;"> -0.7046 (0.2586) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Walk </td>
   <td style="text-align:center;"> -0.7276 (0.1694) </td>
   <td style="text-align:center;"> -0.7240 (0.1696) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Share ride 2 </td>
   <td style="text-align:center;"> 0.2037 (0.1246) </td>
   <td style="text-align:center;"> 0.2458 (0.1241) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Share ride 3++ </td>
   <td style="text-align:center;"> 1.0161 (0.1926) </td>
   <td style="text-align:center;"> 1.0923 (0.1909) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Transit </td>
   <td style="text-align:center;"> 1.2037 (0.1678) </td>
   <td style="text-align:center;"> 1.3024 (0.1657) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Bike </td>
   <td style="text-align:center;"> 0.4609 (0.3601) </td>
   <td style="text-align:center;"> 0.4829 (0.3613) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Walk </td>
   <td style="text-align:center;"> 0.1074 (0.2508) </td>
   <td style="text-align:center;"> 0.0936 (0.2524) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Share ride 2 </td>
   <td style="text-align:center;"> 0.0010 (0.0004) </td>
   <td style="text-align:center;"> 0.0016 (0.0004) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Share ride 3++ </td>
   <td style="text-align:center;"> 0.0013 (0.0005) </td>
   <td style="text-align:center;"> 0.0022 (0.0005) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Transit </td>
   <td style="text-align:center;"> 0.0021 (0.0004) </td>
   <td style="text-align:center;"> 0.0031 (0.0004) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Bike </td>
   <td style="text-align:center;"> 0.0008 (0.0012) </td>
   <td style="text-align:center;"> 0.0019 (0.0012) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Walk </td>
   <td style="text-align:center;"> 0.0018 (0.0008) </td>
   <td style="text-align:center;"> 0.0029 (0.0007) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I(cost/hhinc) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.0528 (0.0108) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Num.Obs. </td>
   <td style="text-align:center;"> 5029 </td>
   <td style="text-align:center;"> 5029 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> AIC </td>
   <td style="text-align:center;"> 6906.7 </td>
   <td style="text-align:center;"> 6941.6 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BIC </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Log.Lik. </td>
   <td style="text-align:center;"> -3424.361 </td>
   <td style="text-align:center;"> -3441.782 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho2 </td>
   <td style="text-align:center;"> 0.2950 </td>
   <td style="text-align:center;"> 0.2914 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho20 </td>
   <td style="text-align:center;"> 0.6200 </td>
   <td style="text-align:center;"> 0.6180 </td>
  </tr>
</tbody>
</table>


The cost by income variable has the expected sign and is statistically significant, but the
overall goodness-of-fit for the cost divided by income model is lower than that for model 15 that
uses cost without interaction with income. However, because theory and common sense suggest
that the importance of cost should decrease with income, we may choose Model 16W despite the
differences in the goodness-of-fit statistics. Since the estimation results contradict our
understanding of the decision making behavior, it is useful to consider other aspects of model
results. In the case of mode choice, we are particularly interested in the relative value of the time
and cost parameters because it measures the implied value of time used by travelers in choosing
their travel mode. Values of time evaluated with earlier models were somewhat lower than
expected when compared to the average wage rate. Using the cost by income formulation in
Model 16W, we can calculate the implied value of time using the relationship developed in
[Section 5.8.2](#section5-8-2).

The implied values of IVT and OVT from Model 16W are substantially higher than those
from Model 15W (Table 6-12) and more in line with our *a priori* expectations. This
improvement in the estimate of values of time more than offsets the difference in goodness-of-fit
so we adopt Model 16W as our preferred specification. Thus, our strong belief in both valuing
time relative to wage rate and higher estimates of the value of time provide evidence which is
strong enough to override the statistical test results. Nonetheless, we may still decide to impose
parameter constraints to obtain higher values of time. 


```r
VOTsimple <- function(model, timevar, costvar) {
  coef(model)[timevar]*0.6/coef(model)[costvar]
}
VOTdistance <- function(model, timevar, timedistvar, dist_value, costvar) {
  (coef(model)[timevar]+(coef(model)[timedistvar]/dist_value))*0.6/coef(model)[costvar]
}

model_15w <- mlogit(chosen ~ mot_tvtt + nm_tvtt + I(mot_ovtt/dist) + cost | 
                      hhinc + vehbywrk + cbddumall + wkempden, data = sf_mlogit_tripcontext)

model_16w <- mlogit(chosen ~ I(cost/hhinc) + mot_tvtt + nm_tvtt + I(mot_ovtt/dist) | 
                      hhinc + vehbywrk + cbddumall + wkempden, data = sf_mlogit_tripcontext)

tibble(
  "Measure" = c("Value of In-Vehicle Time","Value of Out-of-Vehilce Time (10 mile trip)", 
                "Value of Out-of-Vehilce Time (20 mile trip)"),
  "Model 15W" = c(
    paste("$", round(VOTsimple(model_15w,"mot_tvtt","cost"),2), "/hr"),
    paste("$", round(VOTdistance(model_15w, "mot_tvtt", "I(mot_ovtt/dist)", 10,"cost"),2), "/hr"), 
    paste("$", round(VOTdistance(model_15w, "mot_tvtt", "I(mot_ovtt/dist)", 20,"cost"),2), "/hr")
  ), 
  "Model 16W (Wage Rate = $21.20)" = c(
    paste( coef(model_16w)["mot_tvtt"] / coef(model_16w)["I(cost/hhinc)"] * 21.20, "$ /hr)"), 
    (coef(model_16w)["mot_tvtt"] + coef(model_16w)["I(mot_ovtt/dist)"] / 10) / coef(model_16w)["I(cost/hhinc)"] * 21.20,
    (coef(model_16w)["mot_tvtt"] + coef(model_16w)["I(mot_ovtt/dist)"] / 20) / coef(model_16w)["I(cost/hhinc)"] * 21.20
  )) %>%
  kbl(caption = "Implied Value of Time in Models 15W and 16W") %>%
  kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:impliedVOT15-16W)Implied Value of Time in Models 15W and 16W</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Measure </th>
   <th style="text-align:left;"> Model 15W </th>
   <th style="text-align:left;"> Model 16W (Wage Rate = $21.20) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Value of In-Vehicle Time </td>
   <td style="text-align:left;"> $ 5.88 /hr </td>
   <td style="text-align:left;"> 8.10313592785373 $ /hr) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Value of Out-of-Vehilce Time (10 mile trip) </td>
   <td style="text-align:left;"> $ 9.25 /hr </td>
   <td style="text-align:left;"> 13.4216399185657 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Value of Out-of-Vehilce Time (20 mile trip) </td>
   <td style="text-align:left;"> $ 7.57 /hr </td>
   <td style="text-align:left;"> 10.7623879232097 </td>
  </tr>
</tbody>
</table>


```r
modelsummary(
  list("15W" = model_15w, "16W" = model_16w), 
  coef_map = c("mot_tvtt" = "Motorized Travel Time", 
               "nm_tvtt" = "Non-motorized Travel Time",
               "I(mot_ovtt/dist)" = "Motorized time per distance",
               "cost" = "Trip Cost",
               "I(cost/hhinc)" = "Trip cost divided by income"
               )
)
```

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> 15W </th>
   <th style="text-align:center;"> 16W </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Motorized Travel Time </td>
   <td style="text-align:center;"> -0.023 </td>
   <td style="text-align:center;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.004) </td>
   <td style="text-align:center;"> (0.004) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Non-motorized Travel Time </td>
   <td style="text-align:center;"> -0.047 </td>
   <td style="text-align:center;"> -0.045 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.006) </td>
   <td style="text-align:center;"> (0.006) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Motorized time per distance </td>
   <td style="text-align:center;"> -0.132 </td>
   <td style="text-align:center;"> -0.133 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.020) </td>
   <td style="text-align:center;"> (0.020) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Trip Cost </td>
   <td style="text-align:center;"> -0.002 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.000) </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Trip cost divided by income </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.053 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.011) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Num.Obs. </td>
   <td style="text-align:center;"> 5029 </td>
   <td style="text-align:center;"> 5029 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> AIC </td>
   <td style="text-align:center;"> 6906.7 </td>
   <td style="text-align:center;"> 6941.6 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BIC </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Log.Lik. </td>
   <td style="text-align:center;"> -3424.361 </td>
   <td style="text-align:center;"> -3441.782 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho2 </td>
   <td style="text-align:center;"> 0.295 </td>
   <td style="text-align:center;"> 0.291 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho20 </td>
   <td style="text-align:center;"> 0.620 </td>
   <td style="text-align:center;"> 0.618 </td>
  </tr>
</tbody>
</table>


### Additional Model Refinement
Generally, it is appropriate to test the preferred model specification against a variety of other
specifications; particularly reviewing decisions made earlier in the model development process.
Such testing would include reducing model complexity by the elimination of selected variables
(e.g., dropping either the CBD Dummy or Employment Density variables or combining some of
the alternative specific parameters), changing the form used for inclusion of different variables
(e.g., replacing income by log of income) or adding new variables which substantially improve
the explanatory power and behavioral realism of the model.

In this section, we consider simplifying the model specification by dropping variables
that are not statistically significant or by collapsing alternative specific variables that do not
differ across alternatives. The cost and time parameters are all significant and should be
included because they represent the impact of policy changes in mode service attributes. Among
the traveler and context variables, those for income have the lowest t-statistics so might be
considered for elimination; however, we prefer to keep these in the model since income
differences are important in mode selection, particularly for transit. However, the extremely low 
values and lack of significance for the shared ride alternatives suggest that income has no
differential impact on the choice of drive alone versus any of the shared ride alternatives and
these variables should be dropped from the model (or constrained to zero). In addition, the
parameter for the number of automobiles by number of workers variable for shared ride 3+
alternative is smaller in magnitude than the parameter for the shared ride 2 alternative. This is
counter-intuitive as we expect shared ride 3+ travelers to be more sensitive to automobile
availability. This can be addressed by constraining the alternative specific variables for the
shared ride modes to be equal (we accomplish by summing the two variables). The estimation
results for the simplified specification (constraining income for the shared ride alternatives to
zero, and constraining the automobile ownership by number of workers variable for the two
shared ride alternatives to be equal) and Model 16W are reported in Table 6-13.

The goodness-of-fit for the two models are very close, suggesting that the constraints
imposed to simplify the model do not significantly impact the explanatory power of the model.
The results of the likelihood ratio test confirm that the restrictions imposed in Model 17W
cannot be statistically rejected. The parameter estimates for all the variables have the right sign
and are all statistically significant (except CBD dummy for bike and walk). We therefore select
Model 17W as our preferred model.

As discussed in the next section, the other major approach to searching for improved
models is market segmentation and segmenting the population into groups which are expected to
use different criteria in making their mode choice decisions. 


```r
# Model 17 W
model_17w <- mlogit(chosen ~ I(cost/hhinc) + mot_tvtt + nm_tvtt + I(mot_ovtt/dist) | hhinc + vehbywrk + cbddumall + wkempden, data = sf_mlogit_tripcontext, constPar = c("hhinc:Share ride 2" = 0, "hhinc:Share ride 3++" = 0, "vehbywrk:Share ride 2" = -0.3166, "vehbywrk:Share ride 3++" = -0.3166))

#table 6-13
modelsummary(model_17w)
```

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Model 1 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 2 </td>
   <td style="text-align:center;"> -1.808 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.063) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 3++ </td>
   <td style="text-align:center;"> -3.434 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.126) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Transit </td>
   <td style="text-align:center;"> -0.685 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.244) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Bike </td>
   <td style="text-align:center;"> -1.629 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.426) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Walk </td>
   <td style="text-align:center;"> 0.068 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.346) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I(cost/hhinc) </td>
   <td style="text-align:center;"> -0.052 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.010) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mot_tvtt </td>
   <td style="text-align:center;"> -0.020 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.004) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> nm_tvtt </td>
   <td style="text-align:center;"> -0.045 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.006) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I(mot_ovtt/dist) </td>
   <td style="text-align:center;"> -0.133 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.020) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Transit </td>
   <td style="text-align:center;"> -0.005 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.002) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Bike </td>
   <td style="text-align:center;"> -0.009 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.005) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Walk </td>
   <td style="text-align:center;"> -0.006 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.003) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Transit </td>
   <td style="text-align:center;"> -0.946 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.114) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Bike </td>
   <td style="text-align:center;"> -0.702 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.257) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Walk </td>
   <td style="text-align:center;"> -0.722 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.167) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Share ride 2 </td>
   <td style="text-align:center;"> 0.260 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.123) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Share ride 3++ </td>
   <td style="text-align:center;"> 1.069 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.191) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Transit </td>
   <td style="text-align:center;"> 1.309 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.166) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Bike </td>
   <td style="text-align:center;"> 0.489 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.361) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Walk </td>
   <td style="text-align:center;"> 0.102 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.252) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Share ride 2 </td>
   <td style="text-align:center;"> 0.002 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.000) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Share ride 3++ </td>
   <td style="text-align:center;"> 0.002 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.000) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Transit </td>
   <td style="text-align:center;"> 0.003 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.000) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Bike </td>
   <td style="text-align:center;"> 0.002 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.001) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Walk </td>
   <td style="text-align:center;"> 0.003 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.001) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Num.Obs. </td>
   <td style="text-align:center;"> 5029 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> AIC </td>
   <td style="text-align:center;"> 6946.4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BIC </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Log.Lik. </td>
   <td style="text-align:center;"> -3444.185 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho2 </td>
   <td style="text-align:center;"> 0.291 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho20 </td>
   <td style="text-align:center;"> 0.618 </td>
  </tr>
</tbody>
</table>

## Market Segmentation
The models considered to this point implicitly assume that the entire population, represented by
the sample, uses the same model decision structure, variable and importance weights
(parameters) to select their commute to work mode. That is, we assume that the population is
homogeneous with respect to the importance it places on different aspects of service except as
differentiated by decision-maker characteristics included in the model specification. If this
assumption is incorrect, the estimated model will not adequately represent the underlying
decision processes of the entire population or of distinct behavioral groups within the population.
For example, mode preference may differ between low and high-income travelers as low-income
travelers are expected to be more sensitive to cost and less sensitive to time than high-income
travelers. This phenomenon is incorporated in the preceding models to a limited extent through
the use of alternative specific income variables and cost divided by income in the utility
specification. Market segmentation can be used to determine whether the impact of other
variables is different among population groups. The most common approach to market
segmentation is for the analyst to consider sample segments which are mutually exclusive and
collectively exhaustive (that is, each case is included in one and only one segment). Models are
estimated for the sample associated with each segment and compared to the pooled model (all
segments represented by a single model) to determine if there are statistically significant and
important differences among the market segments.

Market segmentation is usually based on socio-economic and trip related variables such
as income, auto ownership and trip purpose which may be used separately or jointly. Trip
purpose has already been used in our analysis by considering work commute trips exclusively.
Once segmentation variables are selected (income, auto ownership, etc.), different numbers of
segments may be considered for each dimension (e.g., we could use high, medium and low
income segments or only high and low income segments). All members of each segment are
assumed to have identical preferences and identical sensitivities to all the variables in the utility equation.

Analysts will often have some *a priori* ideas about the best segmentation variables and
the appropriate groupings of the population with respect to these variables. In the case of
continuous variables, such as income, the analyst may consider different boundaries between
segments. In cases where the analyst does not have a strong basis for selecting model segments,
he/she can test different combinations of socio-economic and trip-related variables in the data for
segmentation. This approach is limited by the fact that the number of segments grows very fast
with the number of segmentation variables (e.g., three income segments, two gender segments
and three home location segments results in 18 distinct groups). The multiplicity of segments
creates interpretational problems due to the complexity of comparing results among segments
and estimation problems due to the small number of observations in some of the segments (with
as many as 2,000 cases, eighteen segments would be likely to produce many segments with
fewer than 100 cases and some with fewer than 50 cases, well below the threshold for reliable
estimation results). The alternative of pre-defining market segments along one dimension at a
time is practical and easy to implement but it has the disadvantage that this approach does not
account for interactions among the segmentation variables.

### Market Segmentation Tests
The determination of whether to segment the data is based on a comparison of the pooled model
for the entire sample/population and a set of segment specific models for each segment of the
sample/population. This comparison includes: (1) a statistical test, referred to as the market
segmentation or taste variation test, to determine if the segments are statistically different from
one another, (2) statistical significance and reasonableness of the parameters in each of the
segments, and (3) reasonableness of the relationships among parameters in each segment and
between parameters in the different market segments.

The statistical test for market segmentation consists of three steps. First, the sample is
divided into a number of market segments which are mutually exclusive and collectively
exhaustive. A preferred model specification is used to estimate a pooled model for the entire
data set and to estimate models for each market segment. Finally, the goodness-of-fit differences
between the segmented models (taken as a group) and the pooled model are evaluated to
determine if they are statistically different. This test is an extension of the likelihood ratio test
described earlier to test the difference between two models. In this case, the unrestricted model
is the set of all the segmented models and the restricted model is the pooled model which
imposes the restriction that the parameters for each segment are identical. 


```r
sf_work <- read_rds("data/worktrips.rds")

base_model <- mlogit(chosen ~ tvtt + cost | wkempden, data = sf_work)
withincome <- mlogit(chosen ~ tvtt + cost | hhinc + wkempden, data = sf_work)
highincome <- mlogit(chosen ~ tvtt + cost | hhinc + wkempden, 
                     data = sf_work %>% filter(hhinc > 50))
low_income <- mlogit(chosen ~ tvtt + cost | hhinc + wkempden, 
                     data = sf_work %>% filter(hhinc <= 50))

list(
  "Base" = base_model,
  "Income" = withincome,
  "High Income" = highincome,
  "Low Income"  = low_income
) %>%
  modelsummary(fmt = "%.5f", stars = TRUE, statistic_vertical = TRUE)
```

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Base </th>
   <th style="text-align:center;"> Income </th>
   <th style="text-align:center;"> High Income </th>
   <th style="text-align:center;"> Low Income </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 2 </td>
   <td style="text-align:center;"> -2.24062*** </td>
   <td style="text-align:center;"> -2.12010*** </td>
   <td style="text-align:center;"> -2.54700*** </td>
   <td style="text-align:center;"> -2.09159*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.05926) </td>
   <td style="text-align:center;"> (0.10550) </td>
   <td style="text-align:center;"> (0.22662) </td>
   <td style="text-align:center;"> (0.23154) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 3++ </td>
   <td style="text-align:center;"> -3.63954*** </td>
   <td style="text-align:center;"> -3.64748*** </td>
   <td style="text-align:center;"> -4.61183*** </td>
   <td style="text-align:center;"> -3.47000*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.10325) </td>
   <td style="text-align:center;"> (0.17932) </td>
   <td style="text-align:center;"> (0.38424) </td>
   <td style="text-align:center;"> (0.37968) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Transit </td>
   <td style="text-align:center;"> -1.48383*** </td>
   <td style="text-align:center;"> -1.10480*** </td>
   <td style="text-align:center;"> -1.28475*** </td>
   <td style="text-align:center;"> -0.67247** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.10843) </td>
   <td style="text-align:center;"> (0.14602) </td>
   <td style="text-align:center;"> (0.30938) </td>
   <td style="text-align:center;"> (0.27050) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Bike </td>
   <td style="text-align:center;"> -3.04236*** </td>
   <td style="text-align:center;"> -2.37218*** </td>
   <td style="text-align:center;"> -3.02584*** </td>
   <td style="text-align:center;"> -0.59491 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.16821) </td>
   <td style="text-align:center;"> (0.30739) </td>
   <td style="text-align:center;"> (0.69578) </td>
   <td style="text-align:center;"> (0.53300) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Walk </td>
   <td style="text-align:center;"> -0.93828*** </td>
   <td style="text-align:center;"> -0.43252** </td>
   <td style="text-align:center;"> -1.20998** </td>
   <td style="text-align:center;"> -0.24907 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.13652) </td>
   <td style="text-align:center;"> (0.19730) </td>
   <td style="text-align:center;"> (0.49709) </td>
   <td style="text-align:center;"> (0.34167) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tvtt </td>
   <td style="text-align:center;"> -0.04378*** </td>
   <td style="text-align:center;"> -0.04350*** </td>
   <td style="text-align:center;"> -0.04055*** </td>
   <td style="text-align:center;"> -0.04529*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00320) </td>
   <td style="text-align:center;"> (0.00322) </td>
   <td style="text-align:center;"> (0.00468) </td>
   <td style="text-align:center;"> (0.00447) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cost </td>
   <td style="text-align:center;"> -0.00312*** </td>
   <td style="text-align:center;"> -0.00312*** </td>
   <td style="text-align:center;"> -0.00308*** </td>
   <td style="text-align:center;"> -0.00331*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00031) </td>
   <td style="text-align:center;"> (0.00031) </td>
   <td style="text-align:center;"> (0.00039) </td>
   <td style="text-align:center;"> (0.00050) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Share ride 2 </td>
   <td style="text-align:center;"> 0.00104*** </td>
   <td style="text-align:center;"> 0.00109*** </td>
   <td style="text-align:center;"> 0.00131*** </td>
   <td style="text-align:center;"> 0.00078 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00037) </td>
   <td style="text-align:center;"> (0.00037) </td>
   <td style="text-align:center;"> (0.00045) </td>
   <td style="text-align:center;"> (0.00067) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Share ride 3++ </td>
   <td style="text-align:center;"> 0.00211*** </td>
   <td style="text-align:center;"> 0.00212*** </td>
   <td style="text-align:center;"> 0.00158*** </td>
   <td style="text-align:center;"> 0.00294*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00044) </td>
   <td style="text-align:center;"> (0.00044) </td>
   <td style="text-align:center;"> (0.00060) </td>
   <td style="text-align:center;"> (0.00069) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Transit </td>
   <td style="text-align:center;"> 0.00317*** </td>
   <td style="text-align:center;"> 0.00331*** </td>
   <td style="text-align:center;"> 0.00309*** </td>
   <td style="text-align:center;"> 0.00367*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00036) </td>
   <td style="text-align:center;"> (0.00037) </td>
   <td style="text-align:center;"> (0.00048) </td>
   <td style="text-align:center;"> (0.00061) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Bike </td>
   <td style="text-align:center;"> 0.00113 </td>
   <td style="text-align:center;"> 0.00132 </td>
   <td style="text-align:center;"> 0.00137 </td>
   <td style="text-align:center;"> 0.00056 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00103) </td>
   <td style="text-align:center;"> (0.00104) </td>
   <td style="text-align:center;"> (0.00119) </td>
   <td style="text-align:center;"> (0.00219) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Walk </td>
   <td style="text-align:center;"> 0.00221*** </td>
   <td style="text-align:center;"> 0.00236*** </td>
   <td style="text-align:center;"> 0.00177* </td>
   <td style="text-align:center;"> 0.00299*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00059) </td>
   <td style="text-align:center;"> (0.00060) </td>
   <td style="text-align:center;"> (0.00092) </td>
   <td style="text-align:center;"> (0.00085) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 2 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.00197 </td>
   <td style="text-align:center;"> 0.00193 </td>
   <td style="text-align:center;"> 0.00015 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.00155) </td>
   <td style="text-align:center;"> (0.00252) </td>
   <td style="text-align:center;"> (0.00651) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 3++ </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.00028 </td>
   <td style="text-align:center;"> 0.01042*** </td>
   <td style="text-align:center;"> -0.00300 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.00252) </td>
   <td style="text-align:center;"> (0.00392) </td>
   <td style="text-align:center;"> (0.01085) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Transit </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.00708*** </td>
   <td style="text-align:center;"> -0.00509 </td>
   <td style="text-align:center;"> -0.02108*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.00196) </td>
   <td style="text-align:center;"> (0.00328) </td>
   <td style="text-align:center;"> (0.00769) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Bike </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.01254** </td>
   <td style="text-align:center;"> -0.00376 </td>
   <td style="text-align:center;"> -0.07430*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.00531) </td>
   <td style="text-align:center;"> (0.00811) </td>
   <td style="text-align:center;"> (0.01848) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Walk </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.01009*** </td>
   <td style="text-align:center;"> -0.00234 </td>
   <td style="text-align:center;"> -0.01316 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.00304) </td>
   <td style="text-align:center;"> (0.00541) </td>
   <td style="text-align:center;"> (0.00971) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Num.Obs. </td>
   <td style="text-align:center;"> 5029 </td>
   <td style="text-align:center;"> 5029 </td>
   <td style="text-align:center;"> 2591 </td>
   <td style="text-align:center;"> 2438 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> AIC </td>
   <td style="text-align:center;"> 7210.7 </td>
   <td style="text-align:center;"> 7193.1 </td>
   <td style="text-align:center;"> 3470.7 </td>
   <td style="text-align:center;"> 3716.6 </td>
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
   <td style="text-align:center;"> -3593.335 </td>
   <td style="text-align:center;"> -3579.553 </td>
   <td style="text-align:center;"> -1718.350 </td>
   <td style="text-align:center;"> -1841.308 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho2 </td>
   <td style="text-align:center;"> 0.26020 </td>
   <td style="text-align:center;"> 0.26304 </td>
   <td style="text-align:center;"> 0.23484 </td>
   <td style="text-align:center;"> 0.28743 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho20 </td>
   <td style="text-align:center;"> 0.60122 </td>
   <td style="text-align:center;"> 0.60275 </td>
   <td style="text-align:center;"> 0.62986 </td>
   <td style="text-align:center;"> 0.57848 </td>
  </tr>
</tbody>
<tfoot>
<tr>
<td style="padding: 0; border:0;" colspan="100%">
<sup></sup> * p &lt; 0.1, ** p &lt; 0.05, *** p &lt; 0.01</td>
</tr>
</tfoot>
</table>



Thus, the null hypothesis is that $\underline\beta_1 = \underline\beta_2 = ... = \underlineβ_s = ... = \underlineβ_S$ , where βs , is the
vector of coefficients for the $S^{th}$ market segment. Following the approach described in
[CHAPTER 5](#chapter5), we reject the null hypothesis that the restricted model is the correct model at
significance level p if the calculated value of the statistic is greater than the test or critical value.
That is, if: 

\begin{equation}
$\displaystyle -2 \times [l_{R} - l_{U}]\ge \chi^{2}_{n,(p)}$
(\#eq:log-likelihoodtestatlevelp)
\end{equation}

Substituting the log-likelihood for the pooled model for $l_R$ and the sum of market segment
model log-likelihoods for lU in equation 5.16, the null hypothesis, that all segments have the
same choice function, is rejected at level p if:

\begin{equation}
$\displaystyle -2 \times \Bigg[l(\beta) - \sum^{S}_{s=1} l(\beta_{s})\Bigg]\ge \chi^{2}_{n,(p)}$
(\#eq:rejectedlog-likelihoodtestatlevelp)
\end{equation}

Where $l(\beta)$ is the log-likelihood for the pooled model,
      $l(\beta_{s})$ is the log-likelihood of the model estimated with $s^{th}$ market segment,
      $\chi^{2}_{n}$ is the chi-square distribution with n degrees of freedom,
      $n$ is equal to the number of restrictions, $\sum^{S}_{s=1} K_{s} - K$
      $K$ is the number of coefficients in the pooled model, and
      $K_{s}$ is the number of coefficients in the $s^{th}$ market segment model.

$K_{s}$ is generally equal to $K$ in which case $n$ is given by $K x (S-1)$ [^fixedseg]

### Market Segmentation Example
We illustrate the market segmentation test for two cases, automobile ownership (zero/one car
households and households with more than one car), and gender (male and female). In the case
of segmentation by automobile ownership, it is appealing to include a distinct segment for
households with no cars since the mode choice behavior of this segment is very different from
the rest of the population due to their dependence on non-automobile modes. However, the
small size of this segment in the data set, only 160 of the 5029 work trip reports from households
with no cars, precludes use of a no car segment; this group is combined with the one car
ownership households for estimation. Using the same utility specification as in Model 17W, the
estimation results for the pooled and segmented models for auto ownership and for gender are
reported in Table 6-14 and Table 6-15.

We can make the following observations from the estimation results of the automobile
ownership segmentation models (Table 6-14): 

  - The segmented model rejects the pooled model at a very high level of statistical significance
  $-2\times\Bigg[l(\beta) - \sum^{S}_{s=1} l(\beta_{s})\Bigg] = -2\times[-3444.2-(-1049.3-2296.7)] = 196.4$
  - The alternative specific constants for all other modes relative to drive alone are much more
    negative for the higher auto ownership group than for the lower auto ownership group.
    These differences indicate the increased preference for drive alone among persons from
    multi-car households. This makes intuitive sense, as travelers in households with fewer
    automobiles are more likely to choose non-automobile modes, all else being equal. 
  - The alternative specific income coefficients are insignificant or marginally significant for
    both segments suggesting that the effect of income differences is adequately explained by the
    segment difference.
    

```r
# uses Model 17W as the basis
model_17w_lowcars <- mlogit(chosen ~ I(cost/hhinc) + mot_tvtt + nm_tvtt + I(mot_ovtt/dist) | hhinc + vehbywrk + cbddumall + wkempden, data = sf_mlogit_tripcontext %>% filter(numveh <= 1), constPar = c("hhinc:Share ride 2" = 0, "hhinc:Share ride 3++" = 0, "vehbywrk:Share ride 2" = -3.015, "vehbywrk:Share ride 3++" = -3.015))
model_17w_highcars <- mlogit(chosen ~ I(cost/hhinc) + mot_tvtt + nm_tvtt + I(mot_ovtt/dist) | hhinc + vehbywrk + cbddumall + wkempden, data = sf_mlogit_tripcontext %>% filter(numveh >= 2), constPar = c("hhinc:Share ride 2" = 0, "hhinc:Share ride 3++" = 0, "vehbywrk:Share ride 2" = -0.241, "vehbywrk:Share ride 3++" = -0.241))

# table 6-14
list(
  "Pooled Model" = model_17w,
  "0-1 Car HH's" = model_17w_lowcars,
  "2+ Car HH's" = model_17w_highcars
) %>%
  modelsummary(fmt = "%.5f", stars = TRUE, statistic_vertical = TRUE)
```

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Pooled Model </th>
   <th style="text-align:center;"> 0-1 Car HH's </th>
   <th style="text-align:center;"> 2+ Car HH's </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 2 </td>
   <td style="text-align:center;"> -1.80786*** </td>
   <td style="text-align:center;"> 0.59322*** </td>
   <td style="text-align:center;"> -1.97908*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.06253) </td>
   <td style="text-align:center;"> (0.13324) </td>
   <td style="text-align:center;"> (0.07282) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 3++ </td>
   <td style="text-align:center;"> -3.43378*** </td>
   <td style="text-align:center;"> -0.78485*** </td>
   <td style="text-align:center;"> -3.72017*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.12556) </td>
   <td style="text-align:center;"> (0.22753) </td>
   <td style="text-align:center;"> (0.15277) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Transit </td>
   <td style="text-align:center;"> -0.68484*** </td>
   <td style="text-align:center;"> 2.25826*** </td>
   <td style="text-align:center;"> -2.16287*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.24373) </td>
   <td style="text-align:center;"> (0.38045) </td>
   <td style="text-align:center;"> (0.38267) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Bike </td>
   <td style="text-align:center;"> -1.62890*** </td>
   <td style="text-align:center;"> 0.97715 </td>
   <td style="text-align:center;"> -3.21797*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.42578) </td>
   <td style="text-align:center;"> (0.66850) </td>
   <td style="text-align:center;"> (0.73350) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Walk </td>
   <td style="text-align:center;"> 0.06816 </td>
   <td style="text-align:center;"> 2.90719*** </td>
   <td style="text-align:center;"> -1.53470*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.34577) </td>
   <td style="text-align:center;"> (0.51554) </td>
   <td style="text-align:center;"> (0.57472) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I(cost/hhinc) </td>
   <td style="text-align:center;"> -0.05242*** </td>
   <td style="text-align:center;"> -0.02267 </td>
   <td style="text-align:center;"> -0.09808*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.01040) </td>
   <td style="text-align:center;"> (0.01380) </td>
   <td style="text-align:center;"> (0.01608) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mot_tvtt </td>
   <td style="text-align:center;"> -0.02019*** </td>
   <td style="text-align:center;"> -0.02107*** </td>
   <td style="text-align:center;"> -0.01870*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00381) </td>
   <td style="text-align:center;"> (0.00604) </td>
   <td style="text-align:center;"> (0.00513) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> nm_tvtt </td>
   <td style="text-align:center;"> -0.04545*** </td>
   <td style="text-align:center;"> -0.04401*** </td>
   <td style="text-align:center;"> -0.04503*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00577) </td>
   <td style="text-align:center;"> (0.00811) </td>
   <td style="text-align:center;"> (0.00872) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I(mot_ovtt/dist) </td>
   <td style="text-align:center;"> -0.13287*** </td>
   <td style="text-align:center;"> -0.11312*** </td>
   <td style="text-align:center;"> -0.19437*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.01964) </td>
   <td style="text-align:center;"> (0.02595) </td>
   <td style="text-align:center;"> (0.03307) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Transit </td>
   <td style="text-align:center;"> -0.00532*** </td>
   <td style="text-align:center;"> -0.00645* </td>
   <td style="text-align:center;"> 0.00036 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00198) </td>
   <td style="text-align:center;"> (0.00355) </td>
   <td style="text-align:center;"> (0.00263) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Bike </td>
   <td style="text-align:center;"> -0.00864* </td>
   <td style="text-align:center;"> -0.01166 </td>
   <td style="text-align:center;"> -0.00192 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00515) </td>
   <td style="text-align:center;"> (0.00949) </td>
   <td style="text-align:center;"> (0.00650) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Walk </td>
   <td style="text-align:center;"> -0.00600* </td>
   <td style="text-align:center;"> -0.01200** </td>
   <td style="text-align:center;"> 0.00067 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00315) </td>
   <td style="text-align:center;"> (0.00596) </td>
   <td style="text-align:center;"> (0.00407) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Transit </td>
   <td style="text-align:center;"> -0.94623*** </td>
   <td style="text-align:center;"> -3.96364*** </td>
   <td style="text-align:center;"> -0.23984* </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.11367) </td>
   <td style="text-align:center;"> (0.27217) </td>
   <td style="text-align:center;"> (0.13456) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Bike </td>
   <td style="text-align:center;"> -0.70211*** </td>
   <td style="text-align:center;"> -2.66404*** </td>
   <td style="text-align:center;"> -0.19047 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.25716) </td>
   <td style="text-align:center;"> (0.62232) </td>
   <td style="text-align:center;"> (0.32833) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Walk </td>
   <td style="text-align:center;"> -0.72180*** </td>
   <td style="text-align:center;"> -3.34226*** </td>
   <td style="text-align:center;"> -0.09746 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.16735) </td>
   <td style="text-align:center;"> (0.37268) </td>
   <td style="text-align:center;"> (0.21095) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Share ride 2 </td>
   <td style="text-align:center;"> 0.25983** </td>
   <td style="text-align:center;"> 0.37243 </td>
   <td style="text-align:center;"> 0.16276 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.12317) </td>
   <td style="text-align:center;"> (0.24084) </td>
   <td style="text-align:center;"> (0.14863) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Share ride 3++ </td>
   <td style="text-align:center;"> 1.06927*** </td>
   <td style="text-align:center;"> 0.22942 </td>
   <td style="text-align:center;"> 1.33024*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.19114) </td>
   <td style="text-align:center;"> (0.40639) </td>
   <td style="text-align:center;"> (0.22088) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Transit </td>
   <td style="text-align:center;"> 1.30881*** </td>
   <td style="text-align:center;"> 1.10644*** </td>
   <td style="text-align:center;"> 1.27854*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.16570) </td>
   <td style="text-align:center;"> (0.25932) </td>
   <td style="text-align:center;"> (0.24433) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Bike </td>
   <td style="text-align:center;"> 0.48929 </td>
   <td style="text-align:center;"> 0.39513 </td>
   <td style="text-align:center;"> 0.48669 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.36110) </td>
   <td style="text-align:center;"> (0.53702) </td>
   <td style="text-align:center;"> (0.50318) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Walk </td>
   <td style="text-align:center;"> 0.10175 </td>
   <td style="text-align:center;"> 0.02974 </td>
   <td style="text-align:center;"> 0.11138 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.25209) </td>
   <td style="text-align:center;"> (0.35050) </td>
   <td style="text-align:center;"> (0.38715) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Share ride 2 </td>
   <td style="text-align:center;"> 0.00158*** </td>
   <td style="text-align:center;"> 0.00204*** </td>
   <td style="text-align:center;"> 0.00107** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00039) </td>
   <td style="text-align:center;"> (0.00073) </td>
   <td style="text-align:center;"> (0.00048) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Share ride 3++ </td>
   <td style="text-align:center;"> 0.00226*** </td>
   <td style="text-align:center;"> 0.00353*** </td>
   <td style="text-align:center;"> 0.00134** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00045) </td>
   <td style="text-align:center;"> (0.00091) </td>
   <td style="text-align:center;"> (0.00055) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Transit </td>
   <td style="text-align:center;"> 0.00313*** </td>
   <td style="text-align:center;"> 0.00316*** </td>
   <td style="text-align:center;"> 0.00288*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00036) </td>
   <td style="text-align:center;"> (0.00067) </td>
   <td style="text-align:center;"> (0.00045) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Bike </td>
   <td style="text-align:center;"> 0.00193 </td>
   <td style="text-align:center;"> 0.00151 </td>
   <td style="text-align:center;"> 0.00161 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00122) </td>
   <td style="text-align:center;"> (0.00188) </td>
   <td style="text-align:center;"> (0.00168) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Walk </td>
   <td style="text-align:center;"> 0.00289*** </td>
   <td style="text-align:center;"> 0.00379*** </td>
   <td style="text-align:center;"> -0.00089 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00074) </td>
   <td style="text-align:center;"> (0.00097) </td>
   <td style="text-align:center;"> (0.00214) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Num.Obs. </td>
   <td style="text-align:center;"> 5029 </td>
   <td style="text-align:center;"> 1221 </td>
   <td style="text-align:center;"> 3808 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> AIC </td>
   <td style="text-align:center;"> 6946.4 </td>
   <td style="text-align:center;"> 2156.6 </td>
   <td style="text-align:center;"> 4651.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BIC </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Log.Lik. </td>
   <td style="text-align:center;"> -3444.185 </td>
   <td style="text-align:center;"> -1049.280 </td>
   <td style="text-align:center;"> -2296.667 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho2 </td>
   <td style="text-align:center;"> 0.29091 </td>
   <td style="text-align:center;"> 0.36645 </td>
   <td style="text-align:center;"> 0.22374 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho20 </td>
   <td style="text-align:center;"> 0.61777 </td>
   <td style="text-align:center;"> 0.52038 </td>
   <td style="text-align:center;"> 0.66339 </td>
  </tr>
</tbody>
<tfoot>
<tr>
<td style="padding: 0; border:0;" colspan="100%">
<sup></sup> * p &lt; 0.1, ** p &lt; 0.05, *** p &lt; 0.01</td>
</tr>
</tfoot>
</table>
    
  - The sensitivity to automobile availability is much higher among low auto ownership
    households where an increase in availability (from 0) will be relatively important, than
    among higher auto ownership households where the number of cars is likely to closely approximate 
    the number of drivers and an increase in availability will be relatively unimportant. 
  - The differences in the alternative specific CBD dummy variables and the Employment
    Density variables are very small and not significant suggesting that these variables could be
    constrained to be equal across auto ownership segments.
  - The differences in the time parameters also are very small and not significant suggesting that
    these variables could be constrained to be equal across auto ownership segments.
  - The magnitude of the cost by income parameter is much smaller in the lower automobile
    ownership segment than in the higher automobile ownership segment indicating that cost
    may be of little importance in households with low car availability.

We can make the following observations from the estimation results of the gender segmentation
models (Table 6-15):
  - The segmented model rejects the pooled model at a very high level of statistical significance.
  - The alternative specific constants relative to the drive alone mode are less negative (more
  positive) in the female segment suggesting the preference for drive alone mode is less
  pronounced among females. This is especially true for the non-motorized modes (bike and
  walk) where the difference in the modal constants between the two groups is large and highly
  significant. 


```r
# uses Model 17W as the basis
model_17w_males <- mlogit(chosen ~ I(cost/hhinc) + mot_tvtt + nm_tvtt + I(mot_ovtt/dist) | hhinc + vehbywrk + cbddumall + wkempden, data = sf_mlogit_tripcontext %>% filter(femdum == 0), constPar = c("hhinc:Share ride 2" = 0, "hhinc:Share ride 3++" = 0, "vehbywrk:Share ride 2" = 0.21, "vehbywrk:Share ride 3++" = 0.21 ))
model_17w_females <- mlogit(chosen ~ I(cost/hhinc) + mot_tvtt + nm_tvtt + I(mot_ovtt/dist) | hhinc + vehbywrk + cbddumall + wkempden, data = sf_mlogit_tripcontext %>% filter(femdum == 1), constPar = c("hhinc:Share ride 2" = 0, "hhinc:Share ride 3++" = 0, "vehbywrk:Share ride 2" = 0.607, "vehbywrk:Share ride 3++" = 0.607 ))
# table 6-15
list(
  "Pooled Model" = model_17w,
  "Males Only" = model_17w_males,
  "Females Only" = model_17w_females
) %>%
  modelsummary(fmt = "%.5f", stars = TRUE, statistic_vertical = TRUE)
```

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Pooled Model </th>
   <th style="text-align:center;"> Males Only </th>
   <th style="text-align:center;"> Females Only </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 2 </td>
   <td style="text-align:center;"> -1.80786*** </td>
   <td style="text-align:center;"> -2.55136*** </td>
   <td style="text-align:center;"> -3.14282*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.06253) </td>
   <td style="text-align:center;"> (0.08243) </td>
   <td style="text-align:center;"> (0.09680) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 3++ </td>
   <td style="text-align:center;"> -3.43378*** </td>
   <td style="text-align:center;"> -4.18976*** </td>
   <td style="text-align:center;"> -4.77064*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.12556) </td>
   <td style="text-align:center;"> (0.16736) </td>
   <td style="text-align:center;"> (0.19156) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Transit </td>
   <td style="text-align:center;"> -0.68484*** </td>
   <td style="text-align:center;"> -1.13739*** </td>
   <td style="text-align:center;"> -1.40011*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.24373) </td>
   <td style="text-align:center;"> (0.35231) </td>
   <td style="text-align:center;"> (0.35479) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Bike </td>
   <td style="text-align:center;"> -1.62890*** </td>
   <td style="text-align:center;"> -2.23618*** </td>
   <td style="text-align:center;"> -1.75391** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.42578) </td>
   <td style="text-align:center;"> (0.53067) </td>
   <td style="text-align:center;"> (0.74120) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Walk </td>
   <td style="text-align:center;"> 0.06816 </td>
   <td style="text-align:center;"> -1.55550*** </td>
   <td style="text-align:center;"> 0.69532 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.34577) </td>
   <td style="text-align:center;"> (0.51427) </td>
   <td style="text-align:center;"> (0.51243) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I(cost/hhinc) </td>
   <td style="text-align:center;"> -0.05242*** </td>
   <td style="text-align:center;"> -0.06050*** </td>
   <td style="text-align:center;"> -0.04241*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.01040) </td>
   <td style="text-align:center;"> (0.01448) </td>
   <td style="text-align:center;"> (0.01502) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mot_tvtt </td>
   <td style="text-align:center;"> -0.02019*** </td>
   <td style="text-align:center;"> -0.01938*** </td>
   <td style="text-align:center;"> -0.02027*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00381) </td>
   <td style="text-align:center;"> (0.00530) </td>
   <td style="text-align:center;"> (0.00568) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> nm_tvtt </td>
   <td style="text-align:center;"> -0.04545*** </td>
   <td style="text-align:center;"> -0.02373*** </td>
   <td style="text-align:center;"> -0.07168*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00577) </td>
   <td style="text-align:center;"> (0.00749) </td>
   <td style="text-align:center;"> (0.00946) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I(mot_ovtt/dist) </td>
   <td style="text-align:center;"> -0.13287*** </td>
   <td style="text-align:center;"> -0.19119*** </td>
   <td style="text-align:center;"> -0.08886*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.01964) </td>
   <td style="text-align:center;"> (0.03154) </td>
   <td style="text-align:center;"> (0.02574) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Transit </td>
   <td style="text-align:center;"> -0.00532*** </td>
   <td style="text-align:center;"> -0.00172 </td>
   <td style="text-align:center;"> -0.00818*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00198) </td>
   <td style="text-align:center;"> (0.00268) </td>
   <td style="text-align:center;"> (0.00302) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Bike </td>
   <td style="text-align:center;"> -0.00864* </td>
   <td style="text-align:center;"> -0.00092 </td>
   <td style="text-align:center;"> -0.03568*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00515) </td>
   <td style="text-align:center;"> (0.00566) </td>
   <td style="text-align:center;"> (0.01371) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Walk </td>
   <td style="text-align:center;"> -0.00600* </td>
   <td style="text-align:center;"> -0.00458 </td>
   <td style="text-align:center;"> -0.00384 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00315) </td>
   <td style="text-align:center;"> (0.00456) </td>
   <td style="text-align:center;"> (0.00445) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Transit </td>
   <td style="text-align:center;"> -0.94623*** </td>
   <td style="text-align:center;"> -0.65309*** </td>
   <td style="text-align:center;"> -0.44164*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.11367) </td>
   <td style="text-align:center;"> (0.15032) </td>
   <td style="text-align:center;"> (0.16648) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Bike </td>
   <td style="text-align:center;"> -0.70211*** </td>
   <td style="text-align:center;"> -0.81375*** </td>
   <td style="text-align:center;"> 0.31291 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.25716) </td>
   <td style="text-align:center;"> (0.31066) </td>
   <td style="text-align:center;"> (0.36089) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vehbywrk × Walk </td>
   <td style="text-align:center;"> -0.72180*** </td>
   <td style="text-align:center;"> -0.43103** </td>
   <td style="text-align:center;"> -0.44055* </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.16735) </td>
   <td style="text-align:center;"> (0.21532) </td>
   <td style="text-align:center;"> (0.25244) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Share ride 2 </td>
   <td style="text-align:center;"> 0.25983** </td>
   <td style="text-align:center;"> 0.07495 </td>
   <td style="text-align:center;"> 0.66040*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.12317) </td>
   <td style="text-align:center;"> (0.17327) </td>
   <td style="text-align:center;"> (0.17732) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Share ride 3++ </td>
   <td style="text-align:center;"> 1.06927*** </td>
   <td style="text-align:center;"> 1.47472*** </td>
   <td style="text-align:center;"> 0.59881* </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.19114) </td>
   <td style="text-align:center;"> (0.23567) </td>
   <td style="text-align:center;"> (0.33441) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Transit </td>
   <td style="text-align:center;"> 1.30881*** </td>
   <td style="text-align:center;"> 1.19366*** </td>
   <td style="text-align:center;"> 1.46080*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.16570) </td>
   <td style="text-align:center;"> (0.24275) </td>
   <td style="text-align:center;"> (0.23542) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Bike </td>
   <td style="text-align:center;"> 0.48929 </td>
   <td style="text-align:center;"> 0.30632 </td>
   <td style="text-align:center;"> 1.08042* </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.36110) </td>
   <td style="text-align:center;"> (0.46846) </td>
   <td style="text-align:center;"> (0.59858) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cbddumall × Walk </td>
   <td style="text-align:center;"> 0.10175 </td>
   <td style="text-align:center;"> 0.20364 </td>
   <td style="text-align:center;"> -0.02633 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.25209) </td>
   <td style="text-align:center;"> (0.37784) </td>
   <td style="text-align:center;"> (0.35494) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Share ride 2 </td>
   <td style="text-align:center;"> 0.00158*** </td>
   <td style="text-align:center;"> 0.00096* </td>
   <td style="text-align:center;"> 0.00303*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00039) </td>
   <td style="text-align:center;"> (0.00053) </td>
   <td style="text-align:center;"> (0.00066) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Share ride 3++ </td>
   <td style="text-align:center;"> 0.00226*** </td>
   <td style="text-align:center;"> 0.00062 </td>
   <td style="text-align:center;"> 0.00507*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00045) </td>
   <td style="text-align:center;"> (0.00061) </td>
   <td style="text-align:center;"> (0.00078) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Transit </td>
   <td style="text-align:center;"> 0.00313*** </td>
   <td style="text-align:center;"> 0.00253*** </td>
   <td style="text-align:center;"> 0.00454*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00036) </td>
   <td style="text-align:center;"> (0.00045) </td>
   <td style="text-align:center;"> (0.00065) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Bike </td>
   <td style="text-align:center;"> 0.00193 </td>
   <td style="text-align:center;"> 0.00055 </td>
   <td style="text-align:center;"> 0.00401* </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00122) </td>
   <td style="text-align:center;"> (0.00149) </td>
   <td style="text-align:center;"> (0.00220) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wkempden × Walk </td>
   <td style="text-align:center;"> 0.00289*** </td>
   <td style="text-align:center;"> 0.00135 </td>
   <td style="text-align:center;"> 0.00525*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.00074) </td>
   <td style="text-align:center;"> (0.00104) </td>
   <td style="text-align:center;"> (0.00116) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Num.Obs. </td>
   <td style="text-align:center;"> 5029 </td>
   <td style="text-align:center;"> 2842 </td>
   <td style="text-align:center;"> 2187 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> AIC </td>
   <td style="text-align:center;"> 6946.4 </td>
   <td style="text-align:center;"> 3875.2 </td>
   <td style="text-align:center;"> 3195.9 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BIC </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Log.Lik. </td>
   <td style="text-align:center;"> -3444.185 </td>
   <td style="text-align:center;"> -1908.617 </td>
   <td style="text-align:center;"> -1568.968 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho2 </td>
   <td style="text-align:center;"> 0.29091 </td>
   <td style="text-align:center;"> 0.26396 </td>
   <td style="text-align:center;"> 0.30038 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho20 </td>
   <td style="text-align:center;"> 0.61777 </td>
   <td style="text-align:center;"> 0.62519 </td>
   <td style="text-align:center;"> 0.59961 </td>
  </tr>
</tbody>
<tfoot>
<tr>
<td style="padding: 0; border:0;" colspan="100%">
<sup></sup> * p &lt; 0.1, ** p &lt; 0.05, *** p &lt; 0.01</td>
</tr>
</tfoot>
</table>

  - The female segment parameters for alternative specific variables; Income, Autos per Worker,
    CBD Dummy and Employment Density are generally more favorable to non-auto modes and
    especially bike and walk, but the differences are small and marginally or not significant.
  - Both groups show almost identical sensitivity to motorized in-vehicle travel time. However,
    the female group is more sensitive to non-motorized travel time while the male group is more
    sensitive to out-of-vehicle time.
  - The female segment exhibits a much lower sensitivity to cost than males.
  
The above observations demonstrate that taste variations exist between the auto ownership
segments and between the gender segments. However, in each case, the differences appear to be
associated with a subset of parameters. One approach to simplifying the segmentation is to
adopt a pooled model which includes segment related parameters where the differences are
important[^extensivedis]. For example, such a model would at a minimum include different parameters for
each of the segment for the following variables:
  - Travel cost by income,
  - Total travel time for non-motorized modes, and
  - Out-of-vehicle time by distance.

## Summary
This chapter demonstrates the development of an MNL model specification for work mode to
choice using data from the San Francisco Bay Area for a realistic context. We start with
relatively simple model specifications and develop more complex models which provide
additional insight into the behavioral choices being made. We begin with the variables: travel
cost, total travel time and household income. We then develop a more comprehensive model
which includes: 1) cost divided by income to account for travelers different sensitivity to cost
depending on household income, 2) two variables for time by motorized vehicle (which capture
the constraint that OVTT is valued less for longer trips than shorter trips but is valued more
highly than IVTT for all trip distances) and an additional variable for non-motorized personal
transport (walk and bike), 3) alternative specific income variables, 4) number of autos per
worker in the household, 5) location of the work zone (CBD or not), and 6) employment density
of the work location.

The specification search was not necessarily exhaustive and improvements to the final
preferred model specification are possible. The example describes the basis for the decisions
made at each point in the model specification search process. Clearly, different decisions could 
be made at some of these points. Thus, the final model result is based on a complex mix of
empirical results, statistical analysis and judgment. The challenge to the analyst is to make good
judgment, describe the basis for the judgments made, and be prepared to demonstrate the
implications of making different judgments.

In the next chapter, we extend our work to consideration of home-based shop/other trips
and we consider adoption of the more sophisticated nested logit model.

[^statbasis]: As other variables are added to the model, the differences between these two specifications may change providing a stronger statistical basis for selecting Model 1 or 3.

[^trumodel]: Model in column used to test null hypothesis that the model identified in the row label is the true model. Values are log-likelihood test
statistic, degrees of freedom, and significance of rejection of null hypothesis.

[^valuesoftime]: Values of time in this and subsequent tables are rounded to the nearest ten cents per hour.

[^costbyinc]: This formulation is similar to that of cost divided by income described Section 5.8.2.

[^refsfmodel]: Refer to the “San Francisco Bay Area 1990 Travel Model Development Project”, Compilation of Technical Memoranda, Volume VI.

[^imposedconstraints]: Based on these results, the model developer might impose constraints between the parameters for the time and cost to obtain higher values of time. The student can demonstrate this by modifying models 7 and 9 so that the value of IVT equals $10/hour (retaining all other elements of the
specifications).

[^parsimony]: Parsimony emphasizes the use of less extensive specifications to reduce the burden of forecasting predictive variables and to provide simpler model interpretation.

[^fixedseg]: If one or more segments is defined so that one or more of the variables is fixed for all members of the segment, the parameters for that
segment, $K_{s}$, will be fewer than K. For example, if none of the members of the low income group owned cars in income segmentation, it would not be possible to estimate parameters for the effect of auto ownership in that segment.

[^extensivedis]: For a more extensive discussion see Chapter 7, Section 7.5, in (@benakivalerman, 1985).
