---
output: html_document
editor_options: 
  chunk_output_type: console
---
# Data Assembly and Estimation of Simple Multinomial Logit Models {#estimation-chapter}

```r
# packages used in this chapter
library(tidyverse) # general data munging
library(haven) # read spss data into R
library(mlogit) # multinomial logit estimation
library(modelsummary) # pretty tables
library(kableExtra)   # pretty tables
library(labelled) # point labels

# helping with book creation
library(knitr)
knitr::opts_chunk$set(cache = TRUE)
```


## Introduction {#estimation-intro}
This chapter describes the estimation of basic specifications for the multinomial logit (MNL) model including the collection and organization of data required for model estimation. The chapter is organized as follows: Section \@ref(estimation-data) presents an overview of the data required to estimate mode choice models.
Section \@ref(estimation-collection-methods-traveller) reviews data collection approaches for obtaining traveler and trip-related data. Section \@ref(estimation-collection-methods) discusses the methods for collecting data which
describes the availability and service characteristics of the various modal alternatives.  Section \@ref(estimation-data-structure) illustrates two different data structures used by
software packages for estimation of MNL and NL models. Section \@ref(estimation-sf-work-data) describes the data used to estimate work mode choice model in the San Francisco Bay Region. Section \@ref(estimation-basic) describes preliminary estimation results for mode choice to work based on this data and interpret these results in terms of judgment, descriptive measures and statistical tests. Section \@ref(estimation-value-of-time) goes into more detail on value of time estimates retrieved from choice models. [CHAPTER 6](#specification-chapter) extends this example to the estimation of more sophisticated models.  [CHAPTER 7](#other-purpose-chapter) develops a parallel example for shop/other mode choice in the San Francisco Bay Region.  [CHAPTER 9](#nesting-selection-chapter) extends the examples from previous chapters and explores nested logit models for work and shop/other trips in the San Francisco Bay Region. Additional examples based on data collected in different urban regions are presented in the appendices.

## Data Requirements Overview {#estimation-data}

The first step in the development of a choice model is to assemble data about traveler choice and the variables believed to influence that choice process. In the context of travel mode choice, such data include:

  - Traveler and trip related variables that influence the travelers’ assessment of modal alternatives (*e.g.*, income, automobile ownership, trip purpose, time of day of travel, origin and destination of trip, and travel party size),
  - Mode related variables describing each alternative available to the traveler (e.g., travel time, travel cost and service frequency for carrier modes) and
  -	The observed or reported mode choice of the traveler (the “dependent” or “endogenous” variable).

The first two categories of variables are selected to describe the factors which influence each decision maker’s choice of an alternative.  These independent or exogenous variables are likely to differ across trip purpose.  The commonly used explanatory variables in mode choice models include:

Traveler (Decision Maker) Related Variables:

  -	Income of traveler or traveler's household, 
  -	Number of automobiles in traveler's household,
  -	Number of workers in traveler's household,
  -	Sex of the traveler,
  -	Age group of the traveler,
  -	Functions of these variables such as number of autos divided by number of workers
  
Trip Context Variables:

  -	Trip purpose,
  -	Employment density at the traveler's workplace,
  -	Population density at the home location and
  -	Dummy variable indicating whether the traveler's workplace is in the Central Business District (CBD).
  
Mode (Alternative) Related Variables:

  -	Total travel time,	
  -	In-vehicle travel time,	
  -	Out-of-vehicle travel time,	
  -	Walk time,
  -	Wait time,
  -	Number of transfers	
  -	Transit headway and	
  -	Travel cost.	
  
Interaction of Mode and Traveler or Trip Related Variables:

  -	Travel cost divided by household income,
  -	Travel time or cost interacted with sex or age group of traveler, and
  -	Out-of-vehicle time divided by total trip distance.


## Sources and Methods for Traveler and Trip Related Data Collection {#estimation-collection-methods-traveller}

Traveler and trip related data (including the actual mode choice of the traveler) needed for estimation of mode choice models are generally obtained by surveying a sample of travelers from the population of interest.  This section discusses the types of surveys that may be used to obtain traveler and/or trip-related information (Section \@ref(estimation-survey-types)) and associated sample design considerations (Section \@ref(estimation-survey-considerations)).

### Travel Survey Types {#estimation-survey-types}

There are several types of travel surveys.  The most common of these are household, workplace and intercept surveys.

**Household Travel Surveys** involve contacting respondents in their home and collecting information regarding their household characteristics (*e.g.*, number of members in household, automobile ownership, *etc*.), their personal characteristics (such as income, work status, *etc*.) and the travel decisions made in the recent past (*e.g.*, number of trips, mode of travel for each trip, *etc*.).  Historically, most household traveler surveys were conducted through personal interviews in the respondent’s home.  Currently, most household travel surveys are conducted using telephone or mail-back surveys, or a combination of both.  It is common practice to include travel diaries as a part of the household travel survey.  Travel diaries are a daily log of all trips (including information about trip origin and destination, start and end time, mode of travel, purpose at the origin and destination, *etc*.) made by each household member during a specified time period. This information is used to develop trip generation, trip distribution, and mode choice models for various trip purposes.  Recently, travel diaries have been extended to include detailed information about the activities engaged in at each stop location and at home to provide a better understanding of the motivation for each trip and to associate trips of different purposes with different members of the household.  Also, in some cases, diaries have been collected repeatedly from the same ‘panel’ of respondents to understand changes in their behavior over time.

**Workplace Surveys** involve contacting respondents at their workplace. The information collected is similar to that for household surveys but focuses exclusively on the traveler working at that location and on his/her work and work-related trips.  Such surveys are of particular interest in understanding work commute patterns of individuals and in designing alternative commuter services. 

**Destination Surveys** involve contacting respondents at other destinations.  Similar information is collected as for workplace surveys but the objective is to learn more about travel to other types of destinations and possibly to develop transportation services which better serve such destinations.  

**Intercept Surveys** “intercept” potential respondents during their travel.  The emphasis of the survey is on collecting information about the specific trip being undertaken by the traveler.  Intercept surveys are commonly used for intercity travel studies due to the high cost of identifying intercity travelers through home-based or work-based surveys.  In intercept surveys, travelers are intercepted at a roadside rest area for highway travel and on board carriers (or at carrier terminals) for other modes of travel.  The traveler is usually given a brief survey (paper or interview) for immediate completion or future response and/or recruited for a future phone survey.  A variant of highway intercept surveys is to record the license plate of vehicles and subsequently contact the owners of a sample of vehicles to obtain information on the trip that was observed. Intercept surveys can be used to cover all available modes or they can be used to enrich a household or workplace survey sample by providing additional observations for users of infrequently used modes since few such users are likely to be identified through household or workplace surveys.

### Sampling Design Considerations {#estimation-survey-considerations}

The first issue to consider in sample design is the population of interest in the study. Obviously, the population of interest will depend on the purpose of the study. In the context of urban work mode choice analysis, the population of interest would be all commuters in the urban region. In the context of non-business intercity mode choice, the population of interest would be all non-business intercity travelers in the relevant corridor.  However, most surveys are designed to addresses a number of current or potential analysis and decision issues.  Thus, the population of interest is selected based on the full range of such issues and is likely to include a wide range of households and household members each undertaking a variety of trips.

After identifying the population of interest, the next step in sample design is to determine the unit for sampling. The sampling units should be mutually exclusive and collectively exhaust the population. Thus, if the population of interest is commuters in an urban region, the sampling unit could be firms in the area (whose employees collectively represent the commuting population). Within each firm, all or a sample of workers could be interviewed.  However, if the survey is addressed to multiple urban travel issues, the population of interest is likely to be all individuals or households resident in the urban region.  A comprehensive list of all sampling units constitutes the sampling frame. This may be a directory of firms or households obtained from a combination of public and private sources such as local or regional commerce departments, business directories, tourism offices, utilities, *etc*. Of course, the sampling frame may not always completely represent the population of interest. For example, some commuters may be employed by firms outside the urban region and some households may not have telephones or other utility connections.

Once the sampling frame is determined, a sampling design is used to select a sample of cases. The most common class of sampling procedures is probability sampling, where each sampling unit has a pre-determined probability of being selected into the survey sample. 

A probability sampling procedure in which each sampling unit has an equal probability of being selected is simple random sampling.  In this method, the sampling units are selected randomly from the sampling frame. This would apply to household sampling, for example. An alternative approach for work place sampling would be to sample each employer to further sample workers for those employers sampled.  This is referred to as a two-stage sample.  In either case, the result is an unbiased sample which is representative of the population of interest.  Simple random sampling offers the advantage of being easy to understand, communicate, and implement in the field, making it less prone to errors.  However, a random sample may not adequately represent some population segments of interest.  

This problem can be addressed by using stratified random sampling.  This entails partitioning the sampling frame into several mutually exclusive and collectively exhaustive segments (or strata) based on one or more stratification variables, followed by random sampling within each stratum. Thus, households in a region may be stratified by location within the region; city vs. suburban residence; or income.  Similarly, employment firms in a region may be stratified by the number of employees or the type of business. Stratified random sampling may be useful in cases where it is important to understand the characteristics of certain subpopulations as well as the overall population. For example, it might be useful to study the mode choice behavior of employees working for very small employers in a region and compare their behavior with those of employees working for large employers. But if the number of small employers in a region is a small proportion of all employers, they may not be well-represented in a simple random sample.  In such a case, the analyst might stratify the sampling frame to ensure adequate representation of very small employers in the survey sample. Stratified random sampling can also be less expensive than simple random sampling. This can occur, for example, because per-person sampling is less expensive if a few large employers are targeted rather than several smaller ones. Finally, increased dispersion in the range of important independent variables can be increased through “clever” identification of alternative strata based on income, household size, number of vehicles owned or number of workers providing benefits in estimation efficiency.

The use of stratified random sampling does not present any new problems in estimation as long as the stratification variable(s) is (are) exogenous to the choice process. However, in some situations, one may want to use the discrete choice of interest (the dependent or endogenous variable) as the stratification variable. For example, if the bus mode is rarely chosen for urban or intercity travel, a random sampling procedure or even an exogenously stratified sample might not provide sufficient observations of bus riders to understand the factors that affect the choice of the bus mode. In this case, bus riders can be intentionally over sampled by interviewing them at bus stops or on board the buses. Such choice based sampling may also be motivated by cost considerations. Special techniques are required to estimate model parameters using choice based sampling methods. 

A further problem is that it may be difficult to obtain a random sample as it may not be possible to get an up to date and complete list of potential respondents from which to select a sample. This is the primary reason for using "deterministic rules" of sampling. In systematic sampling, sample units are drawn by deterministic rather than random rules.  For example, rather than drawing a random sample of 5 percent all households in a region from a published directory, a systematic sampling plan may pick out every 20th household in the directory. As long as there is no inherent bias in setting up the deterministic rule, the systematic sampling plan is essentially equivalent to random sampling, and the choice of one over the other may be a matter of operational convenience.

In addition to the sampling approaches discussed above, combinations of the approaches can also be used.  For example, enriched sampling uses a combination of household or workplace sampling with choice based sampling to increase the number of transit users in the study data.  As with choice based sampling, special estimation techniques are required to offset the biases associated with this sampling approach.

Another issue in survey sampling is the sample size to be used.  The size of the sample required to adequately represent the population is a function of the level of statistical accuracy and confidence desired from the survey.  The precision of parameter estimates and the statistical validity of estimation results improve with sample size.  However, the cost of the survey also increases with sample size and in many cases it is necessary to restrict the sample size to ensure that the cost of the survey remains within budgetary constraints.  The decision about sample size requires a careful evaluation of the need for adequate data to satisfy study objectives *vis-à-vis* budgetary constraints. Interested readers are referred to @benakivalerman1985 or @borschsupan1987 for a more comprehensive discussion of sampling methods and sample size issues.


## Methods for Collecting Mode Related Data {#estimation-collection-methods}

Surveys can be used to collect information describing the trip maker and his or her household, the context of the trip (purpose, time of day, frequency of travel, origin, and destination), the chosen mode and the respondent’s perception of travel service.  However, objective data about modal service (mode availability and level of service) must be obtained from other sources. Modal data is usually generated from simulation of network service characteristics including carrier schedules and fare and observed volumes, travel times and tolls on roadway links.

Network analysis provides the zone-to-zone in-vehicle travel times for the highway (non-transit) and transit modes (the urban area is divided into several traffic analysis zones for travel demand analysis purposes). The highway out-of-vehicle time by the highway mode is assigned a nominal value to reflect walk access/egress to/from the car. The transit out-of-vehicle time is based on transit schedules, the presence or absence of transfers, and location of bus stops vis-à-vis origin and destination locations. The highway distance of travel is obtained from the network structure and a per-mile vehicle operation cost is applied to obtain highway zone-to-zone driving costs. Parking costs are obtained from per-hour parking rates at the destination zone multiplied by half the estimated duration of the activity pursued at the destination zone (allowing half the parking cost to be charged to the incoming and departing trips) and toll costs can be identified from the network. Transit cost is determined from the actual fare for travel between zones plus any access costs to/from the transit station from/to the origin/destination. The highway in-vehicle times, out-of-vehicle times, and costs are used as the relevant values for driving alone and these values are modified appropriately to reflect increased in-vehicle times and decreased driving/parking costs for the shared ride modes. The travel times for non-motorized modes (such as bike and walk) are obtained from the zone-to-zone distance and an assumed walk/bike speed. Finally, the appropriate travel times and cost between zones is appended to each trip in the trip file based on the origin and destination zones of the trip. 

## Data Structure for Estimation {#estimation-data-structure}


```r
# Read in raw SPSS file
# 
# We received the work mode choice dataset from Laurie Garrow, who had converted
# the file into a labeled SPSS data object. This code reads the file into R
# using the haven::read_spss function, and then creates a new alternative column
# as the label of the alternative number
sf_work_mode <- read_spss("data-raw/Work Trips/SPSS/SF MTC Work MC Data NewVars.sav") %>% 
  mutate(altname = as_factor(altnum, levels = "labels"))

# Convert into mlogit dfidx data frame
# mlogit requires instructions on which rows are the alternative, and which rows
# are the cases. This dataset is in IDCase-ALT format
sf_mlogit <- dfidx(sf_work_mode, idx = c("case", "altname"))

# write to data/ folder for future use
write_rds(sf_mlogit, "data/worktrips.rds")
```


The data collected from the various sources described in the previous sections
must be assembled into a single data set to support model estimation.  This can
be accomplished using a variety of spreadsheet, data base, statistical software
or user prepared programs.  The structure of the resultant data files must
satisfy the format requirements of the software packages designed for choice
model estimation.  The commonly used software packages for discrete choice model
estimation require the data to be structured in one of two formats: a) the trip
format or b) the trip-alternative format.  This are commonly referred to as
IDCase (each record contains all the information for mode choice over
alternatives for a single trip) or IDCase-IDAlt (each record contains all the
information for a single mode available to each trip maker so there is one
record for each mode for each trip).

In the trip format, each record provides all the relevant information about an
individual trip, including the traveler/trip related variables, mode related
variables for all available modes and a variable indicating which alternative
was chosen.  In the trip-alternative format, each record includes information on
the traveler/trip related variables, the attributes of that modal alternative,
and a choice variable that indicates whether the alternative was or was not
chosen [^dataformats].

The two data structures are illustrated in Tables \@ref(tab:trip-alt) and \@ref(tab:trip)
for four observations
(individuals) with up to three modal alternatives available.  The first columns
in both formats is the household and person ID value. In the trip (or IDCase) format, this is
followed by traveler/trip related variables (e.g., income), the level of service
(time and cost in the figure) variables associated with each alternative and a
variable that indicates the chosen alternative.  In the trip-alternative (or
IDCase-IDAlt) format, the second column generally identifies the alternative
number with which that record is associated. Additional columns will generally
include a 0-1 variable indicating the chosen alternative [^altfreq], the number
of alternatives available, traveler/trip related variables mode related
attributes for the alternative with which the record is associated. 

The unavailability of an alternative is indicated in the trip format by zeros
Either of the two data formats may be used to represent the information required
for model estimation.  The choice is based on the programming decisions of the
software developer taking into account data storage and computational
implications of each choice.



```r
#trip-alt
trip_alt <- sf_work_mode  %>%
  filter(case <= 4)  %>%
  select(hhid, perid, Alternative = altname, chosen, IVTT = ivtt, Income = hhinc) 

kbl(trip_alt, caption= "Data Layout Type II: Trip-Alternative Format") %>%
  kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:trip-alt)Data Layout Type II: Trip-Alternative Format</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> hhid </th>
   <th style="text-align:right;"> perid </th>
   <th style="text-align:left;"> Alternative </th>
   <th style="text-align:right;"> chosen </th>
   <th style="text-align:right;"> IVTT </th>
   <th style="text-align:right;"> Income </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Drive alone </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 13.38 </td>
   <td style="text-align:right;"> 42.5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Share ride 2 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 18.38 </td>
   <td style="text-align:right;"> 42.5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Share ride 3+ </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 20.38 </td>
   <td style="text-align:right;"> 42.5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Transit </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 25.90 </td>
   <td style="text-align:right;"> 42.5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Bike </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 40.50 </td>
   <td style="text-align:right;"> 42.5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Drive alone </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 29.92 </td>
   <td style="text-align:right;"> 17.5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Share ride 2 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 34.92 </td>
   <td style="text-align:right;"> 17.5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Share ride 3+ </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 21.92 </td>
   <td style="text-align:right;"> 17.5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Transit </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 22.96 </td>
   <td style="text-align:right;"> 17.5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Bike </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 58.95 </td>
   <td style="text-align:right;"> 17.5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Drive alone </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 8.60 </td>
   <td style="text-align:right;"> 12.5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Share ride 2 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 13.60 </td>
   <td style="text-align:right;"> 12.5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Share ride 3+ </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 15.60 </td>
   <td style="text-align:right;"> 12.5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Transit </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 16.87 </td>
   <td style="text-align:right;"> 12.5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Drive alone </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 30.60 </td>
   <td style="text-align:right;"> 55.0 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Share ride 2 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 35.70 </td>
   <td style="text-align:right;"> 55.0 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Share ride 3+ </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 22.70 </td>
   <td style="text-align:right;"> 55.0 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Transit </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 24.27 </td>
   <td style="text-align:right;"> 55.0 </td>
  </tr>
</tbody>
</table>


```r
trip_format <- sf_work_mode  %>%
  filter(case <= 4)  %>%
  select(hhid, perid, chosen, ivtt, Income = hhinc, altname, altnum) %>%
  group_by(hhid, perid) %>%
  mutate( chosen = altname[which(chosen == 1)], altname = str_c(altname, " - Travel Time")) %>%
  select(-altnum) %>%
  spread(altname, ivtt, fill = 0)

kbl(head(trip_format), caption= "Data Layout Type I: Trip Format") %>%
  kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:trip)Data Layout Type I: Trip Format</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> hhid </th>
   <th style="text-align:right;"> perid </th>
   <th style="text-align:left;"> chosen </th>
   <th style="text-align:right;"> Income </th>
   <th style="text-align:right;"> Bike - Travel Time </th>
   <th style="text-align:right;"> Drive alone - Travel Time </th>
   <th style="text-align:right;"> Share ride 2 - Travel Time </th>
   <th style="text-align:right;"> Share ride 3+ - Travel Time </th>
   <th style="text-align:right;"> Transit - Travel Time </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Drive alone </td>
   <td style="text-align:right;"> 42.5 </td>
   <td style="text-align:right;"> 40.50 </td>
   <td style="text-align:right;"> 13.38 </td>
   <td style="text-align:right;"> 18.38 </td>
   <td style="text-align:right;"> 20.38 </td>
   <td style="text-align:right;"> 25.90 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Transit </td>
   <td style="text-align:right;"> 17.5 </td>
   <td style="text-align:right;"> 58.95 </td>
   <td style="text-align:right;"> 29.92 </td>
   <td style="text-align:right;"> 34.92 </td>
   <td style="text-align:right;"> 21.92 </td>
   <td style="text-align:right;"> 22.96 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Drive alone </td>
   <td style="text-align:right;"> 12.5 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 8.60 </td>
   <td style="text-align:right;"> 13.60 </td>
   <td style="text-align:right;"> 15.60 </td>
   <td style="text-align:right;"> 16.87 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Transit </td>
   <td style="text-align:right;"> 55.0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 30.60 </td>
   <td style="text-align:right;"> 35.70 </td>
   <td style="text-align:right;"> 22.70 </td>
   <td style="text-align:right;"> 24.27 </td>
  </tr>
</tbody>
</table>


## Application Data for Work Mode Choice in the San Francisco Bay Area {#estimation-sf-work-data}

The examples used in previous chapters are based on simulated or hypothetical data to highlight fundamental concepts of multinomial logit choice models.  Henceforth, our discussion of model specification and interpretation of results will be based on application data sets assembled from travel survey and other data collection to support transportation decision making in selected urban regions. Use of real data provides richer examples and “hands-on” experience in estimating mode choice models. The data used in this chapter was collected for the analysis of work trip mode choice in the San Francisco Bay Area in 1990. 

The San Francisco Bay Area work mode choice data set comprises 5,029 home-to-work commute trips in the San Francisco Bay Area.  The data is drawn from the San Francisco Bay Area Household Travel Survey conducted by the Metropolitan Transportation Commission (MTC) in the spring and fall of 1990 (see (@whiteco, 1991) for details of survey sampling and administration procedures). This survey included a one day travel diary for each household member older than five years and detailed individual and household socio-demographic information. 

There are six work mode choice alternatives in the region: drive alone, shared-ride with 2 people, shared ride with 3 or more people, transit, bike, and walk [^mtcmodel]. The drive alone mode is available for a trip only if the trip-maker's household has a vehicle available and if the trip-maker has a driver's license. The shared-ride modes (with 2 people and with 3 or more people) are available for all trips. Transit availability is determined based on the residence and work zones of individuals. The bike mode is deemed available if the one-way home-to-work distance is less than 12 miles, while the walk mode is considered to be available if the one-way home to work distance is less than 4 miles (the distance thresholds to determine bike and walk availability are determined based on the maximum one-way distance of bike and walk-users, respectively).

Level of service data were generated by the Metropolitan Transportation Commission for each zone pair and for each mode.  These data were appended to the home-based work trips based on the origin and destination of each trip. The data includes traveler, trip related area and mode related variables for each trip including in-vehicle travel time, out-of-vehicle travel time, travel cost, travel distance, and a mode availability indicator.

Table \@ref(tab:statsJtoWork) provides information about the availability and usage of each alternative and the average values of in-vehicle time, out-of-vehicle time and travel cost in the sample.  Drive alone is available to most work commuters in the Bay Area and is the most frequently chosen alternative. The shared-ride modes are available for all trips (by construction) and together account for the next largest share of chosen alternatives.  The combined total of drive alone and shared ride trips represent close to 85% of all work trips. Transit trips constitute roughly 10% of work trips, a substantially greater share than in most metropolitan regions in the U.S.  The fraction of trips using non-motorized modes (walk and bike) constitutes a small but not insignificant portion of total trips.


```r
#calculations =======================================
#calculate IVTT
sf_wm_ivtt <- sf_work_mode  %>%
  select(hhid, perid, altnum, chosen, ivtt, hhinc) %>%
  group_by(hhid, perid) %>%
  mutate( chosen = max(chosen * altnum) ) %>%
  spread(altnum, ivtt, fill = 0)
ivtt_raw <- apply(sf_wm_ivtt,2,function(x) mean(x[x>0]))
#calculate OVTT
sf_wm_ovtt <- sf_work_mode  %>%
  select(hhid, perid, altnum, chosen, ovtt, hhinc) %>%
  group_by(hhid, perid) %>%
  mutate( chosen = max(chosen * altnum) ) %>%
  spread(altnum, ovtt, fill = 0)
ovtt_raw <- apply(sf_wm_ovtt,2,function(x) mean(x[x>0]))
#calculate OVTT for walk (using TVTT)
sf_wm_tvtt <- sf_work_mode  %>%
  select(hhid, perid, altnum, chosen, tvtt, hhinc) %>%
  group_by(hhid, perid) %>%
  mutate( chosen = max(chosen * altnum) ) %>%
  spread(altnum, tvtt, fill = 0)
tvtt_raw <- apply(sf_wm_tvtt,2,function(x) mean(x[x>0]))
#calculate market share
Base_model <- mlogit(chosen ~ cost + tvtt | hhinc, data = sf_mlogit)
mrktshr_raw <- Base_model$freq / nrow(sf_wm_tvtt)
#calculate COST
sf_wm_cost <- sf_work_mode  %>%
  select(hhid, perid, altnum, chosen, cost, hhinc) %>%
  group_by(hhid, perid) %>%
  mutate( chosen = max(chosen * altnum) ) %>%
  spread(altnum, cost, fill = 0)
cost_raw <- apply(sf_wm_cost,2,function(x) mean(x[x>0]))

#create the table ==================================
statsJtoWork <- tibble(
  "Mode"= c("1. Drive Alone","2. Shared Ride (2)","3. Shared Ride (3+)", "4. Transit", "5. Bike", "6. Walk"),
  "Fraction of Sample with Mode Available (%)" = c(94.6,100.0,100.0,79.6,34.6,29.4),
  "Market Share (%)" = c(mrktshr_raw) * 100,
  "Average IVTT (minutes)" = c(ivtt_raw[ -c(1:4)]), 
  "Average OVTT (minutes)" = c(ovtt_raw[c(5:9)],  tvtt_raw[c(10)]),
  "Average Cost (1990 cents)" = c(cost_raw[-c(1:4)]))

#display the table =================================
kbl(statsJtoWork, digits = 1,
    caption = "Sample Statistics for Bay Area Journey-to-Work Modal Data") %>% 
  kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:statsJtoWork)Sample Statistics for Bay Area Journey-to-Work Modal Data</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Mode </th>
   <th style="text-align:right;"> Fraction of Sample with Mode Available (%) </th>
   <th style="text-align:right;"> Market Share (%) </th>
   <th style="text-align:right;"> Average IVTT (minutes) </th>
   <th style="text-align:right;"> Average OVTT (minutes) </th>
   <th style="text-align:right;"> Average Cost (1990 cents) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 1. Drive Alone </td>
   <td style="text-align:right;"> 94.6 </td>
   <td style="text-align:right;"> 72.3 </td>
   <td style="text-align:right;"> 20.9 </td>
   <td style="text-align:right;"> 3.7 </td>
   <td style="text-align:right;"> 176.4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2. Shared Ride (2) </td>
   <td style="text-align:right;"> 100.0 </td>
   <td style="text-align:right;"> 10.3 </td>
   <td style="text-align:right;"> 25.2 </td>
   <td style="text-align:right;"> 3.9 </td>
   <td style="text-align:right;"> 89.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 3. Shared Ride (3+) </td>
   <td style="text-align:right;"> 100.0 </td>
   <td style="text-align:right;"> 3.2 </td>
   <td style="text-align:right;"> 26.8 </td>
   <td style="text-align:right;"> 3.9 </td>
   <td style="text-align:right;"> 50.4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 4. Transit </td>
   <td style="text-align:right;"> 79.6 </td>
   <td style="text-align:right;"> 9.9 </td>
   <td style="text-align:right;"> 24.6 </td>
   <td style="text-align:right;"> 28.8 </td>
   <td style="text-align:right;"> 122.8 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5. Bike </td>
   <td style="text-align:right;"> 34.6 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 28.0 </td>
   <td style="text-align:right;"> 3.7 </td>
   <td style="text-align:right;"> NaN </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 6. Walk </td>
   <td style="text-align:right;"> 29.4 </td>
   <td style="text-align:right;"> 3.3 </td>
   <td style="text-align:right;"> NaN </td>
   <td style="text-align:right;"> 48.7 </td>
   <td style="text-align:right;"> NaN </td>
  </tr>
</tbody>
</table>

## Estimation of MNL Model with Basic Specification {#estimation-basic}

We use the San Francisco Bay Area data to estimate a multinomial logit work mode choice model using a basic specification which includes travel time, travel cost and household income as the explanatory variables.  Travel time and travel cost represent mode related attributes; all other things being equal, a faster mode of travel is more likely to be chosen than a slower mode and a less expensive mode is more likely to be chosen than a costlier mode.  Household income is included in the model with the expectation that travelers from high income households are more likely to drive alone than to use other travel modes.

The multinomial logit work trip mode choice models are estimated using ALOGIT, LIMDEP and ELM software, to illustrate differences in the outputs of these packages [^estimation], as well as a specially programmed module for Matlab.  The data sets, input control files, and estimation output results for this a selection of other model specifications for both software packages are included in the CD-ROM supplied with this manual.  The Matlab module code, command files and output for all specifications in the manual are also included in the CD-ROM. 

The travel time (TT) and travel cost (TC) variables are specified as generic in this model.  This implies that an increase of one unit of travel time or travel cost has the same impact on modal utility for all six modes.  Household Income (Inc) is included as an alternative-specific variable. The drive alone mode is considered the base alternative for household income and the modal constants (see section 4.1.2.2 for a discussion of the need for a base alternative for these variables).

The following mode labels are used in the subsequent discussion and equations: DA (drive alone), SR2 (shared ride with 2 people), SR3+ (shared ride with 3 or more people), TR (transit), BK (bike) and WK (walk).  The deterministic portion of the utility for these modes, based on the utility specification discussed above, may be written as:

\begin{equation}
  V_{DA} = \beta_{1} \times TT_{DA} + \beta_{2} \times TC_{DA}
  (\#eq:utilspecDA)
\end{equation}

\begin{equation}
  V_{SR2} = \beta_{SR2} + \beta_{1} \times TT_{SR2} + \beta_{2} \times TC_{SR2} + \gamma_{SR2} \times Inc
  (\#eq:utilspecSR2)
\end{equation}

\begin{equation}
  V_{SR3+} = \beta_{SR3+} + \beta_{1} \times TT_{SR3+} + \beta_{2} \times TC_{SR3+} + \gamma_{SR3+} \times Inc
  (\#eq:utilspecSR3)
\end{equation}

\begin{equation}
  V_{TR} = \beta_{TR} + \beta_{1} \times TT_{TR} + \beta_{2} \times TC_{TR} + \gamma_{TR} \times Inc
  (\#eq:utilspecTR)
\end{equation}

\begin{equation}
  V_{BK} = \beta_{BK} + \beta_{1} \times TT_{BK} + \beta_{2} \times TC_{BK} + \gamma_{BK} \times Inc
  (\#eq:utilspecBK)
\end{equation}

\begin{equation}
  V_{WK} = \beta_{WK} + \beta_{1} \times TT_{WK} + \beta_{2} \times TC_{WK} + \gamma_{WK} \times Inc
  (\#eq:utilspecBK)
\end{equation}

The estimation results reported in this manual are obtained from software
programmed using the `mlogit` package for R, with estimation code embedded in
the document. The
output for the above model specification is shown in structured format in Table
\@ref(tab:basic-estimation-table). Other commercial and free software packages are
available, including ALOGIT, LIMDEP, Biogeme (Python), Apollo (R), and ELM.
The outputs from these and other software package typically include, at least,
the following estimation results:

  - Parameter [^corres] names, parameter estimates, standard errors of these estimates and the corresponding t-statistics for each variable/parameter; 
  - Log-likelihood values at zero (equal probability model), constants only (market shares model) and at convergence and
  - Rho-Squared and other indicators of goodness of fit.

In addition, different software reports a variety of other information either as part of the default output or as a user selected option.  These include:

  - The number of observations,
  -	The number of cases for which each alternative is available,
  -	The number of cases for which each alternative is chosen,
  -	The number of iterations required to obtain convergence, and
  -	The status of the convergence process at each iteration.

The value for the log-likelihood at zero and constants can be obtained for either software by estimating models without (zero) and with (constants) alternative specific constants [^zeromodel] and no other variables.  Further, the log-likelihood at zero can be calculated directly as 

$ \sum_t ln(1/NAlt_t)$

In the next three sections, we review the estimation results for the base model using informal judgment-based tests (section 5.7.1), goodness-of-fit measures (section 5.7.2), and statistical tests (section 5.7.3). These elements, taken together, provide a basis to evaluate each model and to compare models with different specifications. 


```r
base <- mlogit(chosen ~ ivtt + cost, data = sf_mlogit)

# estimate a model with constants only by constraining a single generic variable
# to be zero
market_shares <- mlogit(chosen ~ ivtt, data = sf_mlogit, constPar = c("ivtt" = 0))

# Estimate a null model by constraining ALL the parameters to be zero. 
fixed_coefs <- rep(0,6) %>% setNames(c(names(coef(market_shares)), "ivtt"))
null_model <- mlogit(chosen ~ ivtt, data = sf_mlogit, start = fixed_coefs, iterlim = 0)
```


```r
basic_estimation <- list(
  "Null Model" = null_model,
  "Market Shares" = market_shares,
  "Base Model" = base
)

modelsummary(
  basic_estimation, 
  title = "Estimation Results for Zero Coefficient, Constants Only, and Base Models"
)
```

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:basic-estimation-table)Estimation Results for Zero Coefficient, Constants Only, and Base Models</caption>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Null Model </th>
   <th style="text-align:center;"> Market Shares </th>
   <th style="text-align:center;"> Base Model </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 2 </td>
   <td style="text-align:center;"> 0.000 </td>
   <td style="text-align:center;"> -2.137 </td>
   <td style="text-align:center;"> -2.425 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.044) </td>
   <td style="text-align:center;"> (0.048) </td>
   <td style="text-align:center;"> (0.058) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 3++ </td>
   <td style="text-align:center;"> 0.000 </td>
   <td style="text-align:center;"> -3.303 </td>
   <td style="text-align:center;"> -3.856 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.046) </td>
   <td style="text-align:center;"> (0.081) </td>
   <td style="text-align:center;"> (0.095) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Transit </td>
   <td style="text-align:center;"> 0.000 </td>
   <td style="text-align:center;"> -1.950 </td>
   <td style="text-align:center;"> -2.060 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.053) </td>
   <td style="text-align:center;"> (0.051) </td>
   <td style="text-align:center;"> (0.065) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Bike </td>
   <td style="text-align:center;"> 0.000 </td>
   <td style="text-align:center;"> -3.335 </td>
   <td style="text-align:center;"> -3.424 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.085) </td>
   <td style="text-align:center;"> (0.145) </td>
   <td style="text-align:center;"> (0.166) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Walk </td>
   <td style="text-align:center;"> 0.000 </td>
   <td style="text-align:center;"> -2.040 </td>
   <td style="text-align:center;"> -2.717 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.073) </td>
   <td style="text-align:center;"> (0.085) </td>
   <td style="text-align:center;"> (0.096) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ivtt </td>
   <td style="text-align:center;"> 0.000 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.032 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.003) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.005) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cost </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.005 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.000) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Num.Obs. </td>
   <td style="text-align:center;"> 5029 </td>
   <td style="text-align:center;"> 5029 </td>
   <td style="text-align:center;"> 5029 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> AIC </td>
   <td style="text-align:center;"> 14631.2 </td>
   <td style="text-align:center;"> 8277.8 </td>
   <td style="text-align:center;"> 7600.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BIC </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Log.Lik. </td>
   <td style="text-align:center;"> -7309.601 </td>
   <td style="text-align:center;"> -4132.916 </td>
   <td style="text-align:center;"> -3793.129 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho2 </td>
   <td style="text-align:center;"> -0.505 </td>
   <td style="text-align:center;"> 0.149 </td>
   <td style="text-align:center;"> 0.219 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho20 </td>
   <td style="text-align:center;"> 0.189 </td>
   <td style="text-align:center;"> 0.541 </td>
   <td style="text-align:center;"> 0.579 </td>
  </tr>
</tbody>
</table>


### Informal Tests
A variety of informal tests can be applied to an estimated model.  These tests are designed to assess the reasonableness of the implications of estimated parameters.  The most common tests concern:

  - The sign of parameters (do the associated variables have a positive or negative effect on the alternatives with which they are associated?), 
  - The difference (positive or negative) within sets of alternative specific variables (does the inclusion of this variable have a more or less positive effect on one alternative relative to another?) and
  - The ratio of pairs of parameters (is the ratio between the parameters of the correct sign and in a reasonable range?).

#### Signs of Parameters

The most basic test of the estimation results is to examine the signs of the estimated parameters with theory, intuition and judgment regarding the expected impact of the corresponding variables.  The estimated coefficients on the travel time and cost variables in Table \@ref(tab:basic-estimation-table) are negative, as expected, implying that the utility of a mode decreases as the mode becomes slower and/or more expensive.  This, in turn, will reduce the choice probability of the corresponding mode.

#### Differences in Alternative Specific Variable Parameters across Alternatives

We often have expectations about the impact of decision-maker characteristics on different alternatives.  For example, when analyzing mode choice, we expect a number of variables to be more positive for automobile alternatives, especially Drive Alone, than for other alternatives.  These include income, automobile ownership, home ownership, single family dwelling unit, etc. Since DA is the reference alternative in these models, we expect negative parameters on all alternative specific income variables, with small values for the shared ride alternatives and larger values for other alternatives, to reflect our intuition that increasing income will be associated with decreased preference for all other alternatives relative to drive alone. All the estimated alternative specific income parameters in Table \@ref(tab:basic-estimation-table) Estimation Results for Zero Coefficient, Constants Only and Base Models are negative, as expected, with the exception of the parameter for shared ride 3+.  The positive sign for the shared ride 3+ parameter is counter-intuitive but very small and not significantly different from zero. An approach to address this problem is described in section 5.7.3.1.

Additional informal tests involve comparisons among the estimated income parameters. The differences in the magnitude of these alternative-specific income parameters indicate the relative impact of increasing income on the utility and, hence, the choice probability of each mode. The results reported in Table 5 2 show that an increase in income will have a larger negative effect on the utilities of the non-motorized modes (bike and walk) than on those of transit and shared ride 2 modes. It is important to understand that the change in the choice probability of that alternative is not determined by the sign of the income parameter for a particular alternative but on the value of the parameter relative to the weighted mean of the income parameters across all alternatives, as described in section 4.5. For example, in the base model specification (Table \@ref(tab:basic-estimation-table)), an increase in income will increase the probability of choosing drive alone and shared ride 3+ (the alternatives with the most positive parameters [^altdrivealone]) and will decrease the probability of choosing walk and bike (the alternatives with the smallest, most negative, parameters).  However, the effect on shared ride 2 and transit is unclear; as income increases, they will lose some probability to drive alone and shared ride 3+ and gain some from walk and bike.  The net effect will depend on the difference between the parameter for the alternative of interest and the individual choice probability weighted average of all the alternative specific income parameters (including zero for the base alternative) as illustrated in equation 4.58.

#### The Ratio of Pairs of Parameters

The ratio of the estimated travel time and travel cost parameters provides an
estimate of the value of time implied by the model; this can serve as another
important informal test for evaluating the reasonableness of the model. For
example, in the Base Model reported in Table \@ref(tab:basic-estimation-table),
the implied value of time is $-0.0315962/-0.0050606$ or
6.2435342 cents per minute (the units are
determined from the units of the time and cost variables used in estimation).
This is equivalent to \$6.26 per hour which is much lower that the average wage
rate in the area at the time of the survey, approximately \$21.20 per hour,
suggesting that the estimated value of time may be too low.  We revisit this
issue in greater detail in the next chapter.

Similar ratios may be used to assess the reasonableness of the relative magnitudes of other pairs of parameters.  These include out of vehicle time relative to in vehicle time, travel time reliability (if available) relative to average travel time, etc.

### Overall Goodness-of-Fit Measures

This section presents a descriptive measure, called the rho-squared value ($\rho^2$) which can be used to describe the overall goodness of fit of the model. We can understand the formulation of this value in terms of the following figure which shows the scalar relationship among the log-likelihood values for a zero coefficients model (or the equally likely model), a constants only or market share model, the estimated model and a perfect prediction model. In the figure, LL(0) represents the log-likelihood with zero coefficients (which results in equal likelihood of choosing each available alternative), $LL(0)$ represents the log-likelihood for the constants only model, $LL(\hat{\beta})$  represents the log-likelihood for the estimated model and LL(*) = 0 is the log-likelihood for the perfect prediction model.

<div class="figure">
<img src="img/likelihood_numberline.PNG" alt="Relationship between Different Log-likelihood Measures" width="616" />
<p class="caption">(\#fig:loglikelihooddif)Relationship between Different Log-likelihood Measures</p>
</div>


The relationships among modeling results will always appear in the order shown provided the estimated model includes a full set of alternative specific constants.  That is, the constants only model is always better than the equally likely model, and the estimated model with constants is always better than the constants only model.  The order of different estimated models will vary except that any model which is a restricted version of another model will be to the left of the unrestricted model.

The rho-squared ($\rho_0^2$) value is based on the relationship among the log-likelihood values indicated in Figure 5.2. It is simply the ratio of the distance between the reference model and the estimated model divided by the difference between the reference model and a perfect model.  If the reference model is the equally likely model, the rho square with respect to zero, $\rho_0^2$, is:

\begin{equation}
\rho_0^2 = \frac{LL(\hat{\beta}) - LL(0)}{LL(\star) - LL(0)}
(\#eq:fiveseven)
\end{equation}

Since the log-likelihood value for the perfect model is zero [^predict], the $\rho_0^2$ measure reduces to:

\begin{equation}
\rho_0^2 = 1- \frac{LL(\hat{\beta})}{LL(0)}
(\#eq:fiveeight)
\end{equation}

Similarly, the rho-square with respect to the constants only model is:

\begin{equation}
\rho_0^2 = \frac{LL(\hat{\beta}) - LL(c)}{LL(\star) - LL(c)} = 1- \frac{LL(\hat{\beta})}{LL(c)}
(\#eq:fivenine)
\end{equation}

By definition, the values of both rho-squared measures lie between 0 and 1 (this is similar to the R^2 measure for linear regression models).  A value of zero implies that the model is no better than the reference model, whereas a value of one implies a perfect model; that is, every choice is predicted correctly.

The rho-squared values for the basic model specification in Table \@ref(tab:basic-estimation-table) are computed based on the formulae shown below as:

\begin{equation}
\rho_0^2 = 1- \frac{(-3626.2)}{(-7309.6)} = 0.5039 \qquad \rho_c^2 = 1- \frac{(-3626.2)}{(-4132.9)} = 0.1226
(\#eq:fiveten)
\end{equation}

The rho-squared measures are widely used to describe the goodness of fit for choice models because of their intuitive formulation.  The $\rho_0^2$  measures the improvement due to all elements of the model, including the fit to market shares, which is not very interesting for disaggregate analysis so it should not be used to assess models in which the sample shares are very unequal.  The rho-squared measure with respect to the constant only model, $\rho_c^2$ , controls for the choice proportions in the estimation sample and is therefore a better measure to use for evaluating models.

A problem with both rho-squared measures is that there are no guidelines for a “good” rho-squared value. Consequently, the measures are of limited value in assessing the quality of an estimated model and should be used with caution even in assessing the relative fit among alternative specifications. It is preferable to use the log-likelihood statistic (which has a formal and convenient mechanism to test among alternative model specifications) to support the selection of a preferred specification among alternative specifications.  

Another problem with the rho-squared measures is that they improve no matter what variable is added to the model independent of its importance.  This directly results from the fact that the objective function of the model is being modeled with one or more additional degrees of freedom and that the same data that is used for estimation is used to assess the goodness of fit of the model.  One approach to this problem is to replace the rho-squared measure with an adjusted rho-square measure which is designed to take account of these factors.  The adjusted rho-squared for the zero model is given by:  

\begin{equation}
\bar{\rho_0^2} = \frac{[LL(\hat{\beta}) - K] -LL(0)}{LL(\star) - LL(0)} = 1-\frac{LL(\hat{\beta}) - K}{LL(0)}
(\#eq:fiveeleven)
\end{equation}

where $K$ is the number of degrees of freedom (parameters) used in the model.

The corresponding adjusted rho-squared for the constants only model is given by:  

\begin{equation}
\bar{\rho_c^2} = \frac{LL(\hat{\beta}) - K - (LL(C)-K_{MS}}{LL(\star) - (LL(C)-K_{MS})} = 1-\frac{LL(\hat{\beta}) - K}{LL(C)-K_{MS}}
(\#eq:fivetwelve)
\end{equation}

where $K_{MS}$ is the number of degrees of freedom (parameters) used in the constants only model.

### Statistical Tests
Statistical tests may be used to evaluate formal hypotheses about individual parameters or groups of parameters taken together. In this section we describe each of these tests.

#### Test of Individual Parameters

There is sampling error associated with the model parameters because the model is estimated from only a sample of the relevant population (the relevant population includes all commuters in the Bay Area). The magnitude of the sampling error in a parameter is provided by the standard error associated with that parameter; the larger the standard error, the lower the precision with which the corresponding parameter is estimated. The standard error plays an important role in testing whether a particular parameter is equal to some hypothesized value, as we discuss next.

The statistic used for testing the null hypothesis that a parameter $\hat{\beta_{k}}$ is equal to some hypothesized value, ${\beta_{k}^*}$, is the asymptotic t-statistic, which takes the following form:   

\begin{equation}
\displaystyle t-statistic = \frac{\hat{\beta_{k}}-\beta_{k}^{*}}{S_{k}} 
(\#eq:asymptotict-statistic)
\end{equation}

where $\hat{\beta_{k}}$ is the estimate for the $k^{th}$ parameter,
      $\beta_{k}^{*}$   is the hypothesized value for the $k^{th}$ parameter and
      $S_{k}$           is the standard error of the estimate.


Sufficiently large absolute values of the *t-statistic* lead to the rejection of the null hypothesis that the parameter is equal to the hypothesized value. When the hypothesized value, $\beta_{k}^{*}$, is zero, the t-statistic becomes the ratio of the estimated parameter to the standard error.  The default estimation output from most software packages includes the t-statistic for the test of the hypothesis that the true value is zero.  The rejection of this null hypothesis implies that the corresponding variable has a significant impact on the modal utilities and suggests that the variable should be retained in the model.  Low absolute values of the t-statistic imply that the variable does not contribute significantly to the explanatory power of the model and can be considered for exclusion.  If it is concluded that the hypothesis is not rejected, the equality constraint can be incorporated in the model by creating a new variable $X_{kl} = X_{k} + X_{l}$ .

The selection of a critical value for the t-statistic test is a matter of judgment and depends on the level of confidence with which the analyst wants to test his/her hypotheses. The critical t-values for different levels of confidence for samples sizes larger than 150 (which is the norm in mode choice analysis) are shown in Table 5-3.  It should be apparent that the critical t-value increases with the desired level of confidence.  Thus, one can conclude that a particular variable has no influence on choice (or equivalently that the true parameter associated with the variable is zero) can be rejected at the 90% level of confidence if the absolute value of the t-statistic is greater than 1.645 and at the 95% level of confidence if the t-statistic is greater than 1.960 [^confidlevel].  


```r
tibble(confid = c(.9, .95, .99, .995, .999)) %>%
  mutate(tval=qnorm((1-confid)/2, lower.tail = FALSE)) %>%
  kbl(caption = "Critical t-Values for Selected Confidence Levels and Large Samples",
      col.names = c("Confidence Level", "Critical t-value (two-tailed test)")) %>%
  kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:confidencelevels)Critical t-Values for Selected Confidence Levels and Large Samples</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> Confidence Level </th>
   <th style="text-align:right;"> Critical t-value (two-tailed test) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 0.900 </td>
   <td style="text-align:right;"> 1.644854 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 0.950 </td>
   <td style="text-align:right;"> 1.959964 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 0.990 </td>
   <td style="text-align:right;"> 2.575829 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 0.995 </td>
   <td style="text-align:right;"> 2.807034 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 0.999 </td>
   <td style="text-align:right;"> 3.290527 </td>
  </tr>
</tbody>
</table>


```r
these_colors <- wesanderson::wes_palette("Zissou1")
ggplot(data.frame(x = c(-4,4))) +
  # Plot the pdf
  stat_function(
    fun = function(x) dt(x, df = 29),
    aes(x),
    geom = "area", color = "grey75", fill = "grey90", alpha = 1) +
   # Shade above 2
  stat_function(
    fun = function(x) ifelse(x >= 1.645, dt(x, df = 29), NA),
    aes(x),
    geom = "area", color = NA, fill = these_colors[4], alpha = 1) +
  # Shade above 1.645
   stat_function(
    fun = function(x) ifelse(x >= 2, dt(x, df = 29), NA),
    aes(x),
    geom = "area", color = NA, fill = these_colors[5], alpha = 1) +
  # Shade below -1.645
  stat_function(
    fun = function(x) ifelse(x <= -1.645, dt(x, df = 29), NA),
    aes(x),
    geom = "area", color = NA, fill = these_colors[4], alpha = 1) +
  # Shade below -2
  stat_function(
    fun = function(x) ifelse(x <= -2, dt(x, df = 29), NA),
    aes(x),
    geom = "area", color = NA, fill = these_colors[5], alpha = 1) +
  ggtitle(expression(paste("The", italic(t),
    " distribution with a 90% and 95% confidence interval"))) +
  xlab(expression(italic(t)))  + 
  theme_bw()
```

<img src="05-mnl-estimation_files/figure-html/tdistribution-1.png" width="672" />

We illustrate the use of the t-test by reviewing the t-statistics for each parameter in the initial model specification (Table 5-2). Both the travel cost and travel time parameters have large absolute t-statistic values (20.6 and 16.6, respectively) which lead us to reject the hypothesis that these variables have no effect on modal utilities at a confidence level higher than 99.9%. Thus, these variables should be retained in the model. All of the other t-statistics, except for Income-Shared Ride 2,  Income-Shared Ride 3+ and the walk constant are greater than 1.960 (95% confidence) supporting the inclusion of the corresponding variables.  The t-statistics on the shared ride specific income variables are even less than 1.645 in absolute value (90% confidence), suggesting that the effect of income on the utilities of the shared ride modes may not differentiate them from the reference (drive alone) mode. Consequently, the analyst should consider removing these income variables from the utility function specifications for the shared ride modes. The case is particularly compelling for removal of the income shared ride 3+ variable since the t-statistic is very low and the parameter has a counter-intuitive sign. Another alternative would be to combine the two shared ride income parameters suggesting that income has differential effect between drive alone and shared ride but not between shared ride 2 and shared ride 3+ (when this is done, the combined variable obtains a small negative parameter which is not statistically different from zero).  This variable could be deleted or retained according to the judgment of the analyst as described in Section 6.2.1.

An alternative approach is to report the t-statistic to two or three decimal places and calculate the probability that a t-statistic value of that magnitude or higher would occur due to random variation in sampling as shown in Table 5-4.  This is reported as the significance level, which is the complement of the level of confidence. The significance of each parameter can be read directly from the table.  Parameters with significance greater than 0.05 (lower in magnitude but more significant), provide a stronger basis for rejecting the hypothesis that the true parameter is zero and that the corresponding variable can be excluded from the model. On the other hand, significance levels of 0.163 (for Income-SR2), 0.888 (for Income-SR3+) and 0.287 (for ASC-Walk) provide little evidence about whether the corresponding variable should or should not be included in the model [^retorelim].

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
   <td style="text-align:center;"> -2.178*** (-20.815) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 3++ </td>
   <td style="text-align:center;"> -3.725*** (-20.964) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Transit </td>
   <td style="text-align:center;"> -0.671*** (-5.060) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Bike </td>
   <td style="text-align:center;"> -2.376*** (-7.804) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Walk </td>
   <td style="text-align:center;"> -0.207 (-1.066) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cost </td>
   <td style="text-align:center;"> -0.005*** (-20.597) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tvtt </td>
   <td style="text-align:center;"> -0.051*** (-16.565) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 2 </td>
   <td style="text-align:center;"> -0.002 (-1.397) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 3++ </td>
   <td style="text-align:center;"> 0.000 (0.141) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Transit </td>
   <td style="text-align:center;"> -0.005*** (-2.891) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Bike </td>
   <td style="text-align:center;"> -0.013** (-2.406) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Walk </td>
   <td style="text-align:center;"> -0.010*** (-3.194) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Num.Obs. </td>
   <td style="text-align:center;"> 5029 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> AIC </td>
   <td style="text-align:center;"> 7276.4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BIC </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Log.Lik. </td>
   <td style="text-align:center;"> -3626.186 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho2 </td>
   <td style="text-align:center;"> 0.253 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho20 </td>
   <td style="text-align:center;"> 0.598 </td>
  </tr>
</tbody>
<tfoot>
<tr>
<td style="padding: 0; border:0;" colspan="100%">
<sup></sup> Note: The numbers in the parentheses are the t-statistics</td>
</tr>
</tfoot>
<tfoot>
<tr>
<td style="padding: 0; border:0;" colspan="100%">
<sup></sup> * p &lt; 0.1, ** p &lt; 0.05, *** p &lt; 0.01</td>
</tr>
</tfoot>
</table>
[^siglevels]: Significance levels reported as 0.0000 are equivalent to less than 0.00005

It is important to recognize that a low t-statistic does not require removal of the corresponding variable from the model.  If the analyst has a strong reason to believe that the variable is important, and the parameter sign is correct, it is reasonable to retain the variable in the model.  A low t-statistic and corresponding low level of significance can best be interpreted as providing little or no information rather than as a basis for excluding a variable.  Also, one should be cautious about prematurely deleting variables which are expected to be important as the same variable may be significant when other variables are added to or deleted from the model.  

The lack of significance of the alternative specific walk constant is immaterial since the constants represent the average effect of all the variables not included in the model and should always be retained despite the fact that they do not have a well-understood behavioral interpretation.

#### Test of Linear Relationship between Parameters {#section5-7-3-2}

It is often interesting to determine if two parameters are statistically different from one another or if two parameters are related by a specific value ration.  These tests are similarly based on the t-statistic; however, the formulation of the test is somewhat different from that described in Section 5.7.3.1.  To test the hypothesis $H_{0}:\beta_{k} = \beta_{l}$ vs. $H_{A}:\beta_{k} \ne \beta_{l}$; we use the asymptotic t-statistic, which takes the following form: 

\begin{equation}
\displaystyle t-statistic = \frac{\hat{\beta_{k}}-\hat\beta_{l}}{\sqrt{S_{k}^{2}+S_{l}^{2}-2S_{k,l}}} 
(\#eq:asymptotic H0vsHA)
\end{equation}

where $\hat{\beta_{k}}$, $\hat{\beta_{l}}$ are the estimates for the $k^{th}$ and $l^{th}$ parameters,
      $S_{k}$, $S_{l}$                     are the standard errors of the estimates for the $k^{th}$ and $l^{th}$ parameters and
      $S_{k,l}$                            is the error covariance for the estimates for the $k^{th}$ and $l^{th}$ parameters.


That is the ratio is the differences between the two parameter estimates and the standard deviation of that difference.  As before, sufficiently large absolute values of the *t-statistic* lead to the rejection of the null hypothesis that the parameters are equal. Again, rejection of this null hypothesis implies that the two corresponding variables have a significant different impact on the modal utilities and suggests that the variable should be retained in the model and low absolute values of the t-statistic imply that the variables do not have significantly different effects on the utility function or the explanatory power of the model and can be combined in the model.

This test can be readily extended to the test of a hypothesis that the two parameters are related by a predefined ratio; for example, the parameter for time and cost may be related by an *a priori* value of time.  In that case, the null hypothesis becomes $H_{0}:\beta_{cost} = (VOT) \times \beta_{time}$ and the alternative hypothesis is $H_{A}:\beta_{cost} \ne (VOT) \times \beta_{time}$. The corresponding t-statistic becomes

\begin{equation}
$\displaystyle t-statistic = \frac{\hat{\beta}_{cost}-(VOT)\hat\beta_{time}}{\sqrt{S_{cost}^{2}+(VOT)^{2}S_{time}^{2}-2(VOT)S_{time,cost}}}$
(\#eq:corresponding t-statistic)
\end{equation}

The interpretation is the same as above except that the hypothesis refers to the equality of one parameter to the other parameter times an *a priori* fixed value.  In this case, if it is concluded that the hypothesis is not rejected, the ratio constraint can be incorporated in the model by creating a new variable $X_{time,\ cost} = X_{cost}+(VOT)X_{time}$.

#### Tests of Entire Models

The t-statistic is used to test the hypothesis that a single parameter is equal to some pre-selected value or that there is a linear relationship between a pair of parameters. Sometimes, we wish to test multiple hypotheses simultaneously. This is done by formulating a test statistic which can be used to compare two models provided that one is a restricted version of the other; that is, the restricted model can be obtained by imposing restrictions (setting some parameters to zero, setting pairs of parameters equal to one another and so on) on parameters in the unrestricted model. This test statistic can then be used for any case when one or more restrictions are imposed on a model to obtain another model.

If all the restrictions that distinguish between the restricted and unrestricted models are valid, one would expect the difference in log-likelihood values (at convergence) of the restricted and unrestricted models to be small. If some or all the restrictions are invalid, the difference in log-likelihood values of the restricted and unrestricted models will be “sufficiently” large to reject the hypotheses. This underlying logic is the basis for the likelihood ratio test. The test statistic is:

\begin{equation}
\displaystyle -2\times[LL_{R}-LL_{U}]
(\#eq:LLratiotest)
\end{equation}

where $LL_{R}$ is the log-likelihood of the restricted model, and
      $LL_{U}$ is the log-likelihood of the unrestricted model. 

This test-statistic is chi-squared distributed.  Example chi-squared distributions are shown in Figure 5.4. As with the test for individual parameters, the critical value for determining if the statistic is “sufficiently large” to reject the null hypothesis depends on the level of confidence desired by the model developer.  It is also influenced by the number of restrictions [^restrictandconstraint] between the models.  Table 5-5 shows the chi-squared values for selected confidence levels and for different numbers of restrictions.  

Figure 5.5 illustrates the 90% and 95% confidence thresholds on the chi-squared distribution for five degrees of freedom.  The critical chi-square values increase with the desired confidence level and the number of restrictions.


```r
these_colors = wesanderson::wes_palette("Darjeeling1")
tibble(
  x = seq(0, 30, 0.01),
  `5` = dchisq(x, 5),
  `10` = dchisq(x, 10),
  `15` = dchisq(x, 15),
) %>%
  gather("Degrees of Freedom", "Chi-Squared", -x) %>%
  ggplot(aes(x = x, y = `Chi-Squared`, color = `Degrees of Freedom`)) +
  geom_line() + 
  scale_color_manual(values = these_colors) + 
  theme_bw()
```

<div class="figure">
<img src="05-mnl-estimation_files/figure-html/chisqdistrib51015-1.png" alt="Chi-Squared Distribution for 5, 10, and 15 Degrees of Freedom" width="672" />
<p class="caption">(\#fig:chisqdistrib51015)Chi-Squared Distribution for 5, 10, and 15 Degrees of Freedom</p>
</div>


```r
ggplot(data.frame(x = c(0, 20)), aes(x = x)) +
  stat_function(fun = dchisq, args = list(df = 5)) +
  labs( x = "Test Values", y = "PDF") + 
  theme_bw()
```

<div class="figure">
<img src="05-mnl-estimation_files/figure-html/chisq-critdiagram-1.png" alt="Chi-Squared Distribution for 5 Degrees of Freedom Showing 90% and 95% confidence Thresholds" width="672" />
<p class="caption">(\#fig:chisq-critdiagram)Chi-Squared Distribution for 5 Degrees of Freedom Showing 90% and 95% confidence Thresholds</p>
</div>


<table class=" lightable-classic" style='font-family: "Arial Narrow", "Source Sans Pro", sans-serif; margin-left: auto; margin-right: auto;'>
<caption>(\#tab:table5-5)Critical Chi-Squared ($\chi^2$) Values for Selected Confidence Levels by Number of Restrictions</caption>
 <thead>
<tr>
<th style="empty-cells: hide;" colspan="1"></th>
<th style="padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="9"><div style="border-bottom: 1px solid #111111; margin-bottom: -1px; ">Number of Restrictions</div></th>
</tr>
  <tr>
   <th style="text-align:center;"> Level.of.Conf. </th>
   <th style="text-align:center;"> X1 </th>
   <th style="text-align:center;"> X2 </th>
   <th style="text-align:center;"> X3 </th>
   <th style="text-align:center;"> X4 </th>
   <th style="text-align:center;"> X5 </th>
   <th style="text-align:center;"> X7 </th>
   <th style="text-align:center;"> X10 </th>
   <th style="text-align:center;"> X12 </th>
   <th style="text-align:center;"> X15 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 90% </td>
   <td style="text-align:center;"> 2.71 </td>
   <td style="text-align:center;"> 4.61 </td>
   <td style="text-align:center;"> 6.25 </td>
   <td style="text-align:center;"> 7.78 </td>
   <td style="text-align:center;"> 9.24 </td>
   <td style="text-align:center;"> 12.01 </td>
   <td style="text-align:center;"> 15.99 </td>
   <td style="text-align:center;"> 18.54 </td>
   <td style="text-align:center;"> 22.31 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 95% </td>
   <td style="text-align:center;"> 3.84 </td>
   <td style="text-align:center;"> 5.99 </td>
   <td style="text-align:center;"> 7.81 </td>
   <td style="text-align:center;"> 9.49 </td>
   <td style="text-align:center;"> 11.07 </td>
   <td style="text-align:center;"> 14.06 </td>
   <td style="text-align:center;"> 18.31 </td>
   <td style="text-align:center;"> 21.02 </td>
   <td style="text-align:center;"> 25.00 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 99% </td>
   <td style="text-align:center;"> 6.63 </td>
   <td style="text-align:center;"> 9.21 </td>
   <td style="text-align:center;"> 11.34 </td>
   <td style="text-align:center;"> 13.28 </td>
   <td style="text-align:center;"> 15.09 </td>
   <td style="text-align:center;"> 18.48 </td>
   <td style="text-align:center;"> 23.21 </td>
   <td style="text-align:center;"> 26.21 </td>
   <td style="text-align:center;"> 30.58 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 99.5% </td>
   <td style="text-align:center;"> 7.88 </td>
   <td style="text-align:center;"> 10.60 </td>
   <td style="text-align:center;"> 12.84 </td>
   <td style="text-align:center;"> 14.86 </td>
   <td style="text-align:center;"> 16.75 </td>
   <td style="text-align:center;"> 20.28 </td>
   <td style="text-align:center;"> 25.19 </td>
   <td style="text-align:center;"> 28.30 </td>
   <td style="text-align:center;"> 32.80 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 99.9% </td>
   <td style="text-align:center;"> 10.83 </td>
   <td style="text-align:center;"> 13.82 </td>
   <td style="text-align:center;"> 16.27 </td>
   <td style="text-align:center;"> 18.47 </td>
   <td style="text-align:center;"> 20.51 </td>
   <td style="text-align:center;"> 24.32 </td>
   <td style="text-align:center;"> 29.59 </td>
   <td style="text-align:center;"> 32.91 </td>
   <td style="text-align:center;"> 37.70 </td>
  </tr>
</tbody>
</table>

The likelihood ratio test can be applied to test null hypotheses involving the exclusion of groups of variables from the model.  Table 5-6 illustrates the tests of two hypotheses describing restriction on some or all the parameters in the San Francisco Bay Area commuter mode choice model.  The first hypothesis is that all the parameters are equal to zero. The formal statement of the null hypothesis in this case, is:

\begin{equation}
\displaystyle H_{0,a}:\beta_{Travel\ Time} = \beta_{Travel\ Cost} = 0, \\
\beta_{SR2} = \beta_{SR3} = \beta_{TR} = \beta_{WK} = \beta_{BK} = 0, and \\
\beta_{Income-SR2} = \beta_{Income-SR3} = \beta_{Income-Transit} = \beta_{Income-Bike} = \beta_{Income-Walk} = 0
(\#eq:nullhypothesiscase)
\end{equation}

This test is not very useful because we almost always reject the null hypothesis that all coefficients are zero. A somewhat more useful null hypothesis is that the variables in the initial model specification provide no additional information in addition to the market share information represented by the alternative specific constants.  The restrictions for this null hypothesis are:

\begin{equation}
\displaystyle H_{0,b}:\beta_{Travel\ Time} = \beta_{Travel\ Cost} = 0, and \\
\beta_{Income-SR2} = \beta_{Income-SR3+} = \beta_{Income-Transit}, and \\
\beta_{Income-Bike} = \beta_{Income-Walk} = 0
(\#eq:restrictionsnullhypothesiscase)
\end{equation}

The log-likelihood values needed to test each of these hypotheses are reported in Table \@ref(tab:basic-estimation-table).  In each case, we include the log-likelihood of the restricted and unrestricted models, the calculated chi-square value and the number of restrictions or degrees of freedom as shown in Table 5-6. The confidence or significance of the rejection of the null hypothesis in each case can be obtained by referring to Table 5-5, more extensive published tables or software (most spreadsheet programs) that calculates the precise level of confidence/significance associated with each test result.


<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:table5-6)Likelihood Ratio Test for Hypothesis $H_{0,a}$ and $H_{0,b}$</caption>
 <thead>
  <tr>
   <th style="text-align:center;"> Hypothesis </th>
   <th style="text-align:center;"> LL_U </th>
   <th style="text-align:center;"> LL_R </th>
   <th style="text-align:center;"> test_stat </th>
   <th style="text-align:center;"> df </th>
   <th style="text-align:center;"> Crtical Chi-Squared at 99.9% Conf. </th>
   <th style="text-align:center;"> P-value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> $H_{0a}$ </td>
   <td style="text-align:center;"> -3626.186 </td>
   <td style="text-align:center;"> -7309.601 </td>
   <td style="text-align:center;"> 7366.829 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 32.90949 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> $H_{0b}$ </td>
   <td style="text-align:center;"> -3626.186 </td>
   <td style="text-align:center;"> -4132.916 </td>
   <td style="text-align:center;"> 1013.459 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 24.32189 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
</tbody>
</table>


These two applications of the likelihood ratio test correspond to situations where the null hypothesis leads to a highly restrictive model.  These cases are not very interesting since the real value of the likelihood ratio test is in testing null hypotheses which are not so extreme. The log-likelihood ratio test can be applied to test null hypotheses involving the exclusion of selected groups of variables from the model. We consider two such hypotheses.  The first is that the time and cost variables have no impact on the mode choice decision, that is,

$H_{0,C} : \beta_{Travel Time} = \beta_{Travel Cost} = 0$

The second is that income has no effect on the travel mode choice; that is

$H_{0,D} : \beta_{Income-SR2} = \beta_{Income-SR3+} = \beta_{Income-Transit} = \beta_{Income-Bike} = \beta_{Income-Walk} = 0$

The restricted models that reflect each of these hypotheses and the corresponding unrestricted model are reported in Table 5-7 along with their log-likelihood values.  


```r
sf_mlogit_basemodels <- sf_mlogit
 
base_model <- mlogit(chosen ~  tvtt + cost| hhinc, data = sf_mlogit_basemodels)
incomebase_model <- mlogit(chosen ~ 1 | hhinc, data = sf_mlogit_basemodels)
timecostbase_model <- mlogit(chosen ~ tvtt + cost, data = sf_mlogit_basemodels)


base_estimation <- list(
  "Base Model" = base_model,
  "Base Model without Time and Cost Variables" = incomebase_model,
  "Base Model without Income Variables" = timecostbase_model
)

modelsummary(
  base_estimation, fmt = "%.4f",
  title = "Estimation Results for Base Model and its Restricted Versions"
)
```

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:base_models table 5-7)Estimation Results for Base Model and its Restricted Versions</caption>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Base Model </th>
   <th style="text-align:center;"> Base Model without Time and Cost Variables </th>
   <th style="text-align:center;"> Base Model without Income Variables </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 2 </td>
   <td style="text-align:center;"> -2.1780 </td>
   <td style="text-align:center;"> -2.1098 </td>
   <td style="text-align:center;"> -2.3083 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1046) </td>
   <td style="text-align:center;"> (0.0993) </td>
   <td style="text-align:center;"> (0.0547) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 3++ </td>
   <td style="text-align:center;"> -3.7251 </td>
   <td style="text-align:center;"> -3.4722 </td>
   <td style="text-align:center;"> -3.7024 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1777) </td>
   <td style="text-align:center;"> (0.1656) </td>
   <td style="text-align:center;"> (0.0929) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Transit </td>
   <td style="text-align:center;"> -0.6709 </td>
   <td style="text-align:center;"> -1.8198 </td>
   <td style="text-align:center;"> -0.9739 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1326) </td>
   <td style="text-align:center;"> (0.1023) </td>
   <td style="text-align:center;"> (0.0885) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Bike </td>
   <td style="text-align:center;"> -2.3763 </td>
   <td style="text-align:center;"> -2.6721 </td>
   <td style="text-align:center;"> -3.0705 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.3045) </td>
   <td style="text-align:center;"> (0.3028) </td>
   <td style="text-align:center;"> (0.1539) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Walk </td>
   <td style="text-align:center;"> -0.2068 </td>
   <td style="text-align:center;"> -1.5985 </td>
   <td style="text-align:center;"> -0.7040 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1941) </td>
   <td style="text-align:center;"> (0.1636) </td>
   <td style="text-align:center;"> (0.1293) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tvtt </td>
   <td style="text-align:center;"> -0.0513 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.0514 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0031) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.0031) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cost </td>
   <td style="text-align:center;"> -0.0049 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.0049 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0002) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.0002) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 2 </td>
   <td style="text-align:center;"> -0.0022 </td>
   <td style="text-align:center;"> -0.0004 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0016) </td>
   <td style="text-align:center;"> (0.0015) </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 3++ </td>
   <td style="text-align:center;"> 0.0004 </td>
   <td style="text-align:center;"> 0.0030 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0025) </td>
   <td style="text-align:center;"> (0.0024) </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Transit </td>
   <td style="text-align:center;"> -0.0053 </td>
   <td style="text-align:center;"> -0.0022 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0018) </td>
   <td style="text-align:center;"> (0.0016) </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Bike </td>
   <td style="text-align:center;"> -0.0128 </td>
   <td style="text-align:center;"> -0.0122 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0053) </td>
   <td style="text-align:center;"> (0.0054) </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Walk </td>
   <td style="text-align:center;"> -0.0097 </td>
   <td style="text-align:center;"> -0.0089 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0030) </td>
   <td style="text-align:center;"> (0.0030) </td>
   <td style="text-align:center;">  </td>
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
   <td style="text-align:center;"> 8267.2 </td>
   <td style="text-align:center;"> 7289.2 </td>
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
   <td style="text-align:center;"> -4123.615 </td>
   <td style="text-align:center;"> -3637.579 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho2 </td>
   <td style="text-align:center;"> 0.2534 </td>
   <td style="text-align:center;"> 0.1510 </td>
   <td style="text-align:center;"> 0.2511 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho20 </td>
   <td style="text-align:center;"> 0.5976 </td>
   <td style="text-align:center;"> 0.5424 </td>
   <td style="text-align:center;"> 0.5963 </td>
  </tr>
</tbody>
</table>

```r
#This code recreates table 5-7 in the text with the correct coefficients and log likelihood
#However, the output does not have the correct rho-square values, and is missing a number of separate statistics
```


The statistical test of the hypothesis that time and cost have no effect has a chi-square value of

\begin{equation}
\chi^2 = -2(-4123.6-(-3626.2))=994.8
(\#eq:ChisqTimeCostZero)
\end{equation}

with two degrees of freedom (two parameters constrained to zero).  The critical $\chi^2$ with two degrees of freedom at 99.9% confidence (or 0.001 level of significance) is 13.82.  Similarly, the statistical test of the hypothesis that income has no effect on mode choice has a chi-square value of 

\begin{equation}
\chi^2 = -2(-3637.6-(-3626.2))=22.8
(\#eq:chisqIncomeZero)
\end{equation}

with five degrees of freedom (five income parameters are constrained to zero).  The critical $\chi^2$ with five degrees of freedom at 99.9% confidence level (or 0.001 level of significance) is 20.51.   Thus, both null hypotheses can be rejected at very high levels; that is, neither time and cost nor the income variables should be excluded from the model.  The log-likelihood ratio tests for both the above hypotheses are summarized in Table 5-8.


```r
tibble(
  Hypothesis = c("$H_{0c}$","$H_{0d}$"),
  LL_U = rep(base_model$logLik, 2),
  LL_R = c(incomebase_model$logLik, timecostbase_model$logLik)
) %>%
  mutate(
    test_stat = -2 * (LL_R - LL_U),
    df = c(2, 5),
    "Crtical Chi-Squared at 99.9% Conf." = qchisq(0.999, df),
    "P-value" = pchisq(test_stat, df, lower.tail = FALSE)
  ) %>%
  kbl(align = 'c', caption = "Likelihood Ratio Test for Hypothesis $H_{0,c}$ and $H_{0,d}$") %>%
  kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:table5-8)Likelihood Ratio Test for Hypothesis $H_{0,c}$ and $H_{0,d}$</caption>
 <thead>
  <tr>
   <th style="text-align:center;"> Hypothesis </th>
   <th style="text-align:center;"> LL_U </th>
   <th style="text-align:center;"> LL_R </th>
   <th style="text-align:center;"> test_stat </th>
   <th style="text-align:center;"> df </th>
   <th style="text-align:center;"> Crtical Chi-Squared at 99.9% Conf. </th>
   <th style="text-align:center;"> P-value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> $H_{0c}$ </td>
   <td style="text-align:center;"> -3626.186 </td>
   <td style="text-align:center;"> -4123.615 </td>
   <td style="text-align:center;"> 994.8581 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 13.81551 </td>
   <td style="text-align:center;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> $H_{0d}$ </td>
   <td style="text-align:center;"> -3626.186 </td>
   <td style="text-align:center;"> -3637.579 </td>
   <td style="text-align:center;"> 22.7845 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 20.51501 </td>
   <td style="text-align:center;"> 0.0003711 </td>
  </tr>
</tbody>
</table>


#### Non-nested Hypothesis Tests

The likelihood ratio test can only be applied to compare models which differ due to the application of restrictions to one of the models.  Such cases are referred to as nested hypothesis tests. However, there are important cases when the rival models do not have this type of restricted – unrestricted relationship.  For example, we might like to compare the base model to an alternative specification in which the variable cost divided by income is used to replace cost.  This reflects the expectation that the importance of cost diminishes with increasing income.  This analysis can be performed by using the non-nested hypothesis test proposed by (@horowitz1986, 1982).   The non-nested hypothesis test uses the adjusted likelihood ratio index, $\overline{\rho}^2$, to test the hypothesis that the model with the lower $\overline{\rho}^2$ value is the true model [^alttest].  In this test, the null hypothesis that the model with the lower value is the true model is rejected at the significance level determined by the following equation [^benakivalerman]:

\begin{equation}
Significance Level = \Phi \left[-{(2(\overline{\rho}^2_H-\overline{\rho}^2_L) \times LL(0) + (K_H - K_L))}^{1/2}\right]
(\#eq:significancelevel)
\end{equation}

where

- $\overline{\rho}^2_L$ is the adjusted likelihood ratio index for the model with the lower value,
- $\overline{\rho}^2_H$ is the adjusted likelihood ratio index for the model with the higher value
- $K_H$,$K_L$ are the numbers of parameters in models H and L, respectively, and
- $\Phi$ is the standard normal cumulative distribution function.

We illustrate the non-nested hypothesis test by applying it to compare the base model with alternative specifications that replace the cost variable with cost divided by income or cost divided by ln(income).  The estimation results for all three models are presented in Table 5-9.  Since the model using cost not adjusted for income has the best goodness of fit (highest $\overline{\rho}^2$), the null hypotheses for these tests is that the model with cost by income variable or the model with cost by ln(income) is the true model. higher $\overline{\rho}^2$.  Since all the models have the same number of parameters, the term (K_H-K_L) drops out, and the equation for the test of the cost by income model being true is:

\begin{align*}
\Phi \left[\left(-{(2(\overline{\rho}^2_H-\overline{\rho}^2_L) \times LL(0) )}^{1/2}\right)\right] &= \Phi \left[-{(-2(0.5023-0.4897)(-7309.6))}^{1/2}\right] \\
&= \Phi [-13.58] \ll 0.001
(\#eq:testCostbyIncome)
\end{align*}

The corresponding test for the cost by ln(income) being true is:

\begin{align*}
\Phi \left[\left(-{(2(\overline{\rho}^2_H-\overline{\rho}^2_L) \times LL(0) )}^{1/2}\right)\right] &= \Phi \left[-{(-2(0.5023-05015)(-7309.6))}^{1/2}\right] \\
&= \Phi [-3.420] < 0.001
(\#eq:testCostbylnIncome)
\end{align*}

The above result implies that the null hypotheses that the models with cost by income variable or cost by ln(income) are true are rejected at a significance level greater than 0.001.  However, the significance of rejection is much lower for the cost by ln(income) model and many analysts would adopt that specification on the grounds that it is conceptually more appropriate.  This specification suggests that the value of money declines with income but the rate of decline diminishes at higher levels of income.


```r
sf_mlogit_costinc <- sf_mlogit %>%
  mutate(
    costbyinc = cost / hhinc,
    costbylninc = cost / log(hhinc)
  )

base_model <- mlogit(chosen ~  tvtt + cost | hhinc, data = sf_mlogit_costinc)
income_model <- mlogit(chosen ~ tvtt + costbyinc | hhinc, data = sf_mlogit_costinc)
lnincome_model <- mlogit(chosen ~ tvtt + costbylninc | hhinc, data = sf_mlogit_costinc)


income_estimation <- list(
  "Base Model" = base_model,
  "Model With Cost By Cost/Income" = income_model,
  "Model With Cost By ln(Income)" = lnincome_model
)

gm <- modelsummary::gof_map
gm$omit <- TRUE

modelsummary(
  income_estimation,
  title = "Models with Cost vs. Cost/Income and Cost/Ln(Income)"
)
```

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:cost_models)Models with Cost vs. Cost/Income and Cost/Ln(Income)</caption>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Base Model </th>
   <th style="text-align:center;"> Model With Cost By Cost/Income </th>
   <th style="text-align:center;"> Model With Cost By ln(Income) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 2 </td>
   <td style="text-align:center;"> -2.178 </td>
   <td style="text-align:center;"> -2.377 </td>
   <td style="text-align:center;"> -2.282 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.105) </td>
   <td style="text-align:center;"> (0.106) </td>
   <td style="text-align:center;"> (0.105) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 3++ </td>
   <td style="text-align:center;"> -3.725 </td>
   <td style="text-align:center;"> -4.080 </td>
   <td style="text-align:center;"> -3.906 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.178) </td>
   <td style="text-align:center;"> (0.175) </td>
   <td style="text-align:center;"> (0.177) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Transit </td>
   <td style="text-align:center;"> -0.671 </td>
   <td style="text-align:center;"> -0.758 </td>
   <td style="text-align:center;"> -0.731 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.133) </td>
   <td style="text-align:center;"> (0.132) </td>
   <td style="text-align:center;"> (0.133) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Bike </td>
   <td style="text-align:center;"> -2.376 </td>
   <td style="text-align:center;"> -2.771 </td>
   <td style="text-align:center;"> -2.556 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.305) </td>
   <td style="text-align:center;"> (0.296) </td>
   <td style="text-align:center;"> (0.301) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Walk </td>
   <td style="text-align:center;"> -0.207 </td>
   <td style="text-align:center;"> -0.598 </td>
   <td style="text-align:center;"> -0.369 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.194) </td>
   <td style="text-align:center;"> (0.195) </td>
   <td style="text-align:center;"> (0.194) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tvtt </td>
   <td style="text-align:center;"> -0.051 </td>
   <td style="text-align:center;"> -0.051 </td>
   <td style="text-align:center;"> -0.051 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.003) </td>
   <td style="text-align:center;"> (0.003) </td>
   <td style="text-align:center;"> (0.003) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cost </td>
   <td style="text-align:center;"> -0.005 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.000) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 2 </td>
   <td style="text-align:center;"> -0.002 </td>
   <td style="text-align:center;"> 0.003 </td>
   <td style="text-align:center;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.002) </td>
   <td style="text-align:center;"> (0.002) </td>
   <td style="text-align:center;"> (0.002) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 3++ </td>
   <td style="text-align:center;"> 0.000 </td>
   <td style="text-align:center;"> 0.010 </td>
   <td style="text-align:center;"> 0.003 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.003) </td>
   <td style="text-align:center;"> (0.002) </td>
   <td style="text-align:center;"> (0.002) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Transit </td>
   <td style="text-align:center;"> -0.005 </td>
   <td style="text-align:center;"> -0.001 </td>
   <td style="text-align:center;"> -0.004 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.002) </td>
   <td style="text-align:center;"> (0.002) </td>
   <td style="text-align:center;"> (0.002) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Bike </td>
   <td style="text-align:center;"> -0.013 </td>
   <td style="text-align:center;"> -0.004 </td>
   <td style="text-align:center;"> -0.010 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.005) </td>
   <td style="text-align:center;"> (0.005) </td>
   <td style="text-align:center;"> (0.005) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Walk </td>
   <td style="text-align:center;"> -0.010 </td>
   <td style="text-align:center;"> -0.002 </td>
   <td style="text-align:center;"> -0.007 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.003) </td>
   <td style="text-align:center;"> (0.003) </td>
   <td style="text-align:center;"> (0.003) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> costbyinc </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.169 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.010) </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> costbylninc </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.019 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.001) </td>
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
   <td style="text-align:center;"> 7460.8 </td>
   <td style="text-align:center;"> 7282.0 </td>
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
   <td style="text-align:center;"> -3718.390 </td>
   <td style="text-align:center;"> -3629.000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho2 </td>
   <td style="text-align:center;"> 0.253 </td>
   <td style="text-align:center;"> 0.234 </td>
   <td style="text-align:center;"> 0.253 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho20 </td>
   <td style="text-align:center;"> 0.598 </td>
   <td style="text-align:center;"> 0.587 </td>
   <td style="text-align:center;"> 0.597 </td>
  </tr>
</tbody>
</table>

## Value of Time {#estimation-value-of-time}

### Value of Time for Linear Utility Function

The value of time, as described in Section 5.7.1.3, is calculated as the ratio of the parameter for time over the parameter for cost.  This ratio assumes that the utility function is linear in both time and cost and that neither value is interacted with any other variables.  That is, when the time and cost portion of the utility function is 

\begin{equation}
V_i = ... + \beta_{TVT}TVT_i + \beta_{Cost}Cost_i + ...
(\#eq:utilityvot)
\end{equation}

the value of time is given by

\begin{equation}
VofT = \beta_{TVT} \Huge/ \normalsize \beta_{Cost}
(\#eq:VoT)
\end{equation}

The units of time value are obtained from the units of the variables used to measure time and cost.  In the Base Model in Table 5.9, the units are minutes and cents.  Thus the value of time in cents per minute implied by this model is -0.0513/-0.0049 = 10.5 cents per minute.  This can be modified to \$ per hour by multiply by  0.6 = (1/100 \$ per cent)/(1/60 hour per minute).

However, in general, the value of time is equal to the ratio between the derivative of utility with respect to time and the derivative of utility with respect to cost.  That is

\begin{equation}
VofT = \frac{\partial{V_i}}{\partial{Time_i}} \Huge/ \normalsize \frac{\partial{V_i}}{\partial{Cost_i}}
(\#eq:VoTderivratio)
\end{equation}

In the case described in Equation 5.24, this produces the ratio in Equation 5.25.  However, this more general formulation allows us to infer the value of time for a variety of special cases in addition to the linear utility case described above. 

### Value of Time when Cost is Interacted with another Variable {#section5-8-2}

This approach can be applied to any case including when either time or cost is interacted with another variable, usually a variable describing the decision maker or the decision context. For example, if cost is divided by income [^incomerate] as in the second model reported in Table 5-9, on the basis that a unit of cost is proportionally less important with increasing income, the utility expression becomes

\begin{equation}
V_{it} = ... + \beta_{TVT}TVT_{it} + \beta_{CostInc}\frac{Cost_{it}}{Income_t} + ...
(\#eq:utilityvotcostinc)
\end{equation}

and the value of time becomes

\begin{equation}
VofT = \frac{\partial{V_i}}{\partial{Time_i}} \Huge/ \normalsize {\frac{\partial{V_i}}{\partial{Cost_i}}} = {\beta_{TVT}} \Huge/ \normalsize {\beta_{CostInc}} \Huge/ \normalsize {Income_i}
(\#eq:VoTcostinc)
\end{equation}

which can be converted to

\begin{equation}
VofT = \frac{\frac{\beta_{TVT}}{\beta_{Cost}}}{Income($1000/year)}{cents/minute}
(\#eq:VoTcostincconvert)
\end{equation}

or

\begin{equation}
VofT = \frac{0.6 \times \frac{\beta_{TVT}}{\beta_{Cost}}}{Income($1000/year)}{$/hour}
\end{equation}

Similarly, the value of time for the third specification in Table 5-9 is

\begin{equation}
VofT = \frac{0.6 \times \frac{\beta_{TVT}}{\beta_{Cost}}}{ln[Income($1000/year)]}{$/hour}
\end{equation}

The value of time implied by each of these formulations is illustrated in Table 5-10 and Figure 5.6 by showing the values of time for different income levels.  In each case, the values of travel time appear to be quite low.  This will be addressed in model specification refinement (Section 6.2.6). 


```r
tibble(
  AnnualIncome = c(25000, 50000, 75000, 100000, 125000)) %>%
  mutate(HourlyWage= AnnualIncome/2000) %>%
  mutate(linear = c(6.26, 6.26, 6.26, 6.26, 6.26)) %>%
  mutate(CostIncome = c(4.53, 9.07, 13.60, 18.13, 21.94)) %>%
  mutate(CostLn = c(5.18, 6.29, 6.95, 7.41, 7.72)) %>%
  knitr::kable( caption = "Value of Time vs. Income",
                col.names = c("Annual Income", "Hourly Wage", "Linear", "Cost/Income", "Cost/LN(Inc.)"))
```

<table>
<caption>(\#tab:valueoftimevsincome)Value of Time vs. Income</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> Annual Income </th>
   <th style="text-align:right;"> Hourly Wage </th>
   <th style="text-align:right;"> Linear </th>
   <th style="text-align:right;"> Cost/Income </th>
   <th style="text-align:right;"> Cost/LN(Inc.) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 25000 </td>
   <td style="text-align:right;"> 12.5 </td>
   <td style="text-align:right;"> 6.26 </td>
   <td style="text-align:right;"> 4.53 </td>
   <td style="text-align:right;"> 5.18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 50000 </td>
   <td style="text-align:right;"> 25.0 </td>
   <td style="text-align:right;"> 6.26 </td>
   <td style="text-align:right;"> 9.07 </td>
   <td style="text-align:right;"> 6.29 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 75000 </td>
   <td style="text-align:right;"> 37.5 </td>
   <td style="text-align:right;"> 6.26 </td>
   <td style="text-align:right;"> 13.60 </td>
   <td style="text-align:right;"> 6.95 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 100000 </td>
   <td style="text-align:right;"> 50.0 </td>
   <td style="text-align:right;"> 6.26 </td>
   <td style="text-align:right;"> 18.13 </td>
   <td style="text-align:right;"> 7.41 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 125000 </td>
   <td style="text-align:right;"> 62.5 </td>
   <td style="text-align:right;"> 6.26 </td>
   <td style="text-align:right;"> 21.94 </td>
   <td style="text-align:right;"> 7.72 </td>
  </tr>
</tbody>
</table>

<img src="05-mnl-estimation_files/figure-html/figure 5-6-1.png" width="672" />


Another approach that can be used in this case is to relate the value of travel directly to the wage rate by assuming that the working year consists of 2000 hours or 120,000 minutes and recognizing that $1000 dollars is equivalent to 100,000 cents.  This gives us 

\begin{equation}
Units_{VofT} = cents \Huge/ \normalsize minute \Huge/ \normalsize $1000 \Huge/ \normalsize year
(\#eq:VoTlncostinc)
\end{equation}
\begin{equation}
 = cents \Huge/ \normalsize minute \Huge/ \normalsize 100,000~cents \Huge/ \normalsize 120,000~minutes
\end{equation}
\begin{equation}
 = 1.2
\end{equation}

That is, there are no units but a simple factor of 1.2.  This is interpreted as the value by which the ratio of the parameters should be multiplied to get the value of travel time as a fraction of the wage rate.  In the cost by income model in Table 5-9 Models with Cost vs. Cost/Income and Cost/Ln(Income), this becomes 

\begin{equation}
VofT = \beta_{TVT} \Huge/ \normalsize \beta_{CostInc} \times 1.2 = \frac{-0.0512}{-0.1692} \times 1.2 = 0.363~Wage~Rate
(\#eq:TVTfracofwagerate)
\end{equation}

which, as before, is quite low. However, as shown in Figure 5.6 and discussed in Section 5.7.3.4, this specification and the related specification for cost by ln(income) have the advantage that the value of time is differentiated across households with different income.  

### Value of Time for Time or Cost Transformation

If time or cost is transformed, it becomes necessary to explicitly take the derivative of utility with respect to both time and cost.  For example, if time enters the utility function using the natural log transformation, to suggest that the utility effect of increasing time decreases with time, the utility function becomes

\begin{equation}
V_{it} = ... + \beta_{ln(TVT)}ln(TVT_{it}) + \beta_{Cost}Cost_{it} + ...
(\#eq:utilitycosttransform)
\end{equation}

and the value of time becomes 

\begin{equation}
VofT = \frac{\partial{V_{it}}}{\partial{Time_{it}}} \Huge/ \normalsize \frac{\partial{V_{it}}}{\partial{Cost_{it}}} = \beta_{ln(TVT)} \Huge/ \normalsize TVT_{it} \Huge/ \normalsize \beta_{Cost} = \frac{\beta_{ln(TVT)}}{\beta_{Cost}} \times \frac{1}{TVT_{it}}
(\#eq:VoTcosttransformalt)
\end{equation}

Similarly, if cost is entered as the natural log of cost, the value of time becomes

\begin{equation}
VofT = \frac{\partial{V_{it}}}{\partial{Time_{it}}} \Huge/ \normalsize \frac{\partial{V_{it}}}{\partial{Cost_{it}}} = \beta_{TVT} \Huge/ \normalsize \beta_{ln(Cost)} \Huge/ \normalsize Cost_{it} = \frac{\beta_{TVT}}{\beta_{ln(Cost)}} \times Cost_{it}
(\#eq:VoTcosttransformlncost)
\end{equation}

which can be reported in a table for selected values of time or plotted in a graph of Value of Time as a function of TVT or Cost, as appropriate (see below).  Models using each of these formulations are estimated and reported, along with the Base Model in Table 5-11. The goodness of fit is substantially improved by using ln(time), which is generally expected, but is worse when using ln(cost), for which there is no conceptual basis. 


```r
base_model <- mlogit(chosen ~  tvtt + cost | hhinc, data = sf_mlogit)
lntravaltime_model <- mlogit(chosen ~ cost + log(tvtt) | hhinc, data = sf_mlogit)
# lots of variables have zero cost, and log(0) = -Inf. To keep this model estimable, we can
# add 0.01 dollars to all alternatives, because log function is monotonically increasing.
lntravelcost_model <- mlogit(chosen ~ tvtt + I(log(cost + 0.01)) | hhinc, data = sf_mlogit)

transformations_estimation <- list(
  "Base Model" = base_model,
  "Model With Log of Travel Time" = lntravaltime_model,
  "Model With Log of Travel Cost" = lntravelcost_model
)

gm <- modelsummary::gof_map
gm$omit <- TRUE

modelsummary(
  transformations_estimation,fmt = "%.4f",
  title = "Base Model and Log Transformations"
)
```

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:Table5-11)Base Model and Log Transformations</caption>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Base Model </th>
   <th style="text-align:center;"> Model With Log of Travel Time </th>
   <th style="text-align:center;"> Model With Log of Travel Cost </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 2 </td>
   <td style="text-align:center;"> -2.1780 </td>
   <td style="text-align:center;"> -1.7457 </td>
   <td style="text-align:center;"> -2.4748 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1046) </td>
   <td style="text-align:center;"> (0.1091) </td>
   <td style="text-align:center;"> (0.1072) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Share ride 3++ </td>
   <td style="text-align:center;"> -3.7251 </td>
   <td style="text-align:center;"> -3.1395 </td>
   <td style="text-align:center;"> -4.3121 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1777) </td>
   <td style="text-align:center;"> (0.1805) </td>
   <td style="text-align:center;"> (0.1782) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Transit </td>
   <td style="text-align:center;"> -0.6709 </td>
   <td style="text-align:center;"> 0.0788 </td>
   <td style="text-align:center;"> 0.0194 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1326) </td>
   <td style="text-align:center;"> (0.1509) </td>
   <td style="text-align:center;"> (0.1371) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Bike </td>
   <td style="text-align:center;"> -2.3763 </td>
   <td style="text-align:center;"> -1.6413 </td>
   <td style="text-align:center;"> -10.4405 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.3045) </td>
   <td style="text-align:center;"> (0.3092) </td>
   <td style="text-align:center;"> (0.5238) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) × Walk </td>
   <td style="text-align:center;"> -0.2068 </td>
   <td style="text-align:center;"> 1.1878 </td>
   <td style="text-align:center;"> -7.7790 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.1941) </td>
   <td style="text-align:center;"> (0.2324) </td>
   <td style="text-align:center;"> (0.4402) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tvtt </td>
   <td style="text-align:center;"> -0.0513 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -0.0602 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0031) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.0032) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cost </td>
   <td style="text-align:center;"> -0.0049 </td>
   <td style="text-align:center;"> -0.0034 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0002) </td>
   <td style="text-align:center;"> (0.0002) </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 2 </td>
   <td style="text-align:center;"> -0.0022 </td>
   <td style="text-align:center;"> -0.0026 </td>
   <td style="text-align:center;"> -0.0009 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0016) </td>
   <td style="text-align:center;"> (0.0016) </td>
   <td style="text-align:center;"> (0.0015) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Share ride 3++ </td>
   <td style="text-align:center;"> 0.0004 </td>
   <td style="text-align:center;"> 0.0001 </td>
   <td style="text-align:center;"> 0.0025 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0025) </td>
   <td style="text-align:center;"> (0.0025) </td>
   <td style="text-align:center;"> (0.0024) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Transit </td>
   <td style="text-align:center;"> -0.0053 </td>
   <td style="text-align:center;"> -0.0066 </td>
   <td style="text-align:center;"> -0.0051 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0018) </td>
   <td style="text-align:center;"> (0.0019) </td>
   <td style="text-align:center;"> (0.0018) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Bike </td>
   <td style="text-align:center;"> -0.0128 </td>
   <td style="text-align:center;"> -0.0125 </td>
   <td style="text-align:center;"> -0.0131 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0053) </td>
   <td style="text-align:center;"> (0.0053) </td>
   <td style="text-align:center;"> (0.0054) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhinc × Walk </td>
   <td style="text-align:center;"> -0.0097 </td>
   <td style="text-align:center;"> -0.0090 </td>
   <td style="text-align:center;"> -0.0089 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.0030) </td>
   <td style="text-align:center;"> (0.0031) </td>
   <td style="text-align:center;"> (0.0031) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> log(tvtt) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -2.3992 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.1244) </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I(log(cost + 0.01)) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> -1.0150 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (0.0502) </td>
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
   <td style="text-align:center;"> 7205.0 </td>
   <td style="text-align:center;"> 7383.4 </td>
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
   <td style="text-align:center;"> -3590.502 </td>
   <td style="text-align:center;"> -3679.717 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho2 </td>
   <td style="text-align:center;"> 0.2534 </td>
   <td style="text-align:center;"> 0.2608 </td>
   <td style="text-align:center;"> 0.2424 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rho20 </td>
   <td style="text-align:center;"> 0.5976 </td>
   <td style="text-align:center;"> 0.6015 </td>
   <td style="text-align:center;"> 0.5916 </td>
  </tr>
</tbody>
</table>

The implications for value of time of these different formulations are shown in Table 5-12 and Table 5-13 Value of Time for Log of Cost Model and also in Figure 5.7 and Figure 5.8.  


```r
# in a log of time model, the value of time is a function of the trip time.
ln_vot <- function(model, ttime){
  ValueCentsMin = coef(model)["log(tvtt)"] / (coef(model)["cost"] * ttime)
}

tibble(
  triptime = c(5, 15, 30, 60, 90, 120),
  vot = ln_vot(lntravaltime_model, triptime)
) %>%
  mutate(vot_dhr = vot * 0.6) %>%
  kbl(digits = 2, 
      caption = "Value of Time for Log of Time Model", 
      col.names = c("Trip Time (min)", "Value of Time (cents/min)", "Value of Time ($/hr)")) %>%
  kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:table5-12)Value of Time for Log of Time Model</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> Trip Time (min) </th>
   <th style="text-align:right;"> Value of Time (cents/min) </th>
   <th style="text-align:right;"> Value of Time ($/hr) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 139.76 </td>
   <td style="text-align:right;"> 83.86 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 46.59 </td>
   <td style="text-align:right;"> 27.95 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 23.29 </td>
   <td style="text-align:right;"> 13.98 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 11.65 </td>
   <td style="text-align:right;"> 6.99 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 7.76 </td>
   <td style="text-align:right;"> 4.66 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:right;"> 5.82 </td>
   <td style="text-align:right;"> 3.49 </td>
  </tr>
</tbody>
</table>


```r
tibble(
  triptime = seq(5, 120, by = 1),
  vot = 0.6 * ln_vot(lntravaltime_model, triptime)
) %>%
ggplot(aes(y = vot, x = triptime)) +
  geom_line() + 
  scale_y_continuous(labels=scales::dollar_format())+
  labs( x= "Time of Trip (min)", y = "Value of Time ($/hr)") + 
  theme_bw()
```

<div class="figure">
<img src="05-mnl-estimation_files/figure-html/figure5-7-1.png" alt="Value of time for log of time model as a function of trip time." width="672" />
<p class="caption">(\#fig:figure5-7)Value of time for log of time model as a function of trip time.</p>
</div>

<table class=" lightable-classic" style='font-family: "Arial Narrow", "Source Sans Pro", sans-serif; margin-left: auto; margin-right: auto;'>
<caption>(\#tab:table5-13)Value of Time for Log of Cost Model</caption>
 <thead>
  <tr>
   <th style="text-align:center;"> Trip cost </th>
   <th style="text-align:center;"> Value of time ($/hr) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> $0.25 </td>
   <td style="text-align:center;"> 0.85 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> $0.50 </td>
   <td style="text-align:center;"> $1.71 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> $1.00 </td>
   <td style="text-align:center;"> $3.42 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> $2.00 </td>
   <td style="text-align:center;"> $6.83 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> $5.00 </td>
   <td style="text-align:center;"> $17.09 </td>
  </tr>
</tbody>
</table>

<img src="05-mnl-estimation_files/figure-html/figure 5-8-1.png" width="672" />

[^dataformats]: The data formats required vary for different programs and are documented in the relevant software.

[^altfreq]: When the same behavior is observed repeatedly for a case, the chosen alternative will be replaced by the
frequency with which each alternative is chosen.

[^mtcmodel]: The estimation reported by the Metropolitan Transportation Commission (Travel Demand Models for the San Francisco Bay Area
(BAYCAST-90): Technical Summary, Metropolitan Transportation Commission, Oakland, California, June 1997) includes drive alone, sharedride
with 2 people, shared ride with 3 or more people, transit with walk access, transit with auto access, bike and walk.

[^estimation]: Essentially identical estimation results are produced by these and a variety of other commercially available and programmer developed
estimation procedures. However, some software applies simplifying assumptions that are not appropriate in every case. See Appendix A for
additional information.

[^zeromodel]: The zero model can be estimated with constants included but restricted to zero, the constants model can be
estimated with constants included and not restricted.

[^corres]: Commonly, the name is selected to match the corresponding variable name.

[^altdrivealone]: If all the reported constants are negative, the alternative with the most positive parameter is drive alone at zero.

[^predict]: The perfect model “predicts” a probability of one for the chosen mode for each and every case so the contribution of each case to the loglikelihood function is ln(1) = 0.

[^confidlevel]: Confidence levels commonly used are in the range of 90% to 99%.

[^retorelim]: Generally, it is good policy to retain or eliminate full sets of constants and alternative specific variables unless
there is a good reason to do otherwise until all other variables have been selected.

[^restrictandconstraint]: The number of restrictions is the number of constraints imposed on the unrestricted model to obtain the restricted model. If three variables are deleted from the unrestricted mode; that is, their parameters are restricted to zero; the number of restrictions is three.

[^alttest]: The alternative test, that the model with the higher $\overline{\rho}^2$ value is the true model, cannot be undertaken as an inferior model can never be used to reject a superior model.

[^benakivalerman]: Modified from Ben-Akiva and Lerman, Chapter 7, 1985

[^incomerate]: The value of income commonly used is the total household income since that value is most commonly collected in surveys. This raises a variety of potential problems in interpretation as the hourly wage rate based on household income is only the wage rate of the worker in a single worker household and does not readily apply to any worker in multi-worker household to non-workers. This issue is not explicitly addressed in this manual but raises more general issues of model interpretation and use of the results.
