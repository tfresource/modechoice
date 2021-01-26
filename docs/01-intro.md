# Introduction {#chapter1}

## Background

Discrete choice models can be used to analyze and predict a decision maker’s
choice of one alternative from a finite set of mutually exclusive and
collectively exhaustive alternatives.  Such models have numerous applications
since many behavioral responses are discrete or qualitative in nature; that is,
they correspond to choices of one or another of a set of alternatives.

The ultimate interest in discrete choice modeling, as in most econometric
modeling, lies in being able to predict the decision making behavior of a group
of individuals (we will use the term "individual" and "decision maker"
interchangeably, though the decision maker may be an individual, a household, a
shipper, an organization, or some other decision making entity).  A further
interest is to determine the relative influence of different attributes of
alternatives and characteristics of decision makers when they make choice
decisions.  For example, transportation analysts may be interested in predicting
the fraction of commuters using each of several travel modes under a variety of
service conditions, or marketing researchers may be interested in examining the
fraction of car buyers selecting each of several makes and models with different
prices and attributes.  Further, they may be interested in predicting this
fraction for different groups of individuals and identifying individuals who are
most likely to favor one or another alternative.  Similarly, they may be
interested in understanding how different groups value different attributes of
an alternative; for example are business air travelers more sensitive to total
travel time or the frequency of flight departures for a chosen destination.
	
There are two basic ways of modeling such aggregate (or group) behavior.  One
approach directly models the aggregate share of all or a segment of decision
makers choosing each alternative as a function of the characteristics of the
alternatives and socio-demographic attributes of the group.  This approach is
commonly referred to as the aggregate approach.  The second approach is to
recognize that aggregate behavior is the result of numerous individual decisions
and to model individual choice responses as a function of the characteristics of
the alternatives available to and socio-demographic attributes of each
individual.  This second approach is referred to as the disaggregate approach.
	
The disaggregate approach has several important advantages over the aggregate
approach to modeling the decision making behavior of a group of individuals.
First, the disaggregate approach explains why an individual makes a particular
choice given her/his circumstances and is, therefore, better able to reflect
changes in choice behavior due to changes in individual characteristics and
attributes of alternatives.  The aggregate approach, on the other hand, rests
primarily on statistical associations among relevant variables at a level other
than that of the decision maker; as a result, it is unable to provide accurate
and reliable estimates of the change in choice behavior due changes in service
or in the population.  Second, the disaggregate approach, because of its causal
nature, is likely to be more transferable to a different point in time and to a
different geographic context, a critical requirement for prediction.  Third,
discrete choice models are being increasingly used to understand behavior so
that the behavior may be changed in a proactive manner through carefully
designed strategies that modify the attributes of alternatives which are
important to individual decision makers.  The disaggregate approach is more
suited for proactive policy analysis since it is causal, less tied to the
estimation data and more likely to include a range of relevant policy variables.
Fourth, the disaggregate approach is more efficient than the aggregate approach
in terms of model reliability per unit cost of data collection.  Disaggregate
data provide substantial variation in the behavior of interest and in the
determinants of that behavior, enabling the efficient estimation of model
parameters.  On the other hand, aggregation leads to considerable loss in
variability, thus requiring much more data to obtain the same level of model
precision.  Finally, disaggregate models, if properly specified, will obtain
un-biased parameter estimates, while aggregate model estimates are known to
produce biased (i.e. incorrect) parameter estimates.
	

## Use of Disaggregate Discrete Choice Models

The behavioral nature of disaggregate models, and the associated advantages of
such models over aggregate models, has led to the widespread use of disaggregate
discrete choice methods in travel demand modeling. A few of these application
contexts below with references to recent work in these areas are: travel mode
choice (reviewed in detail later), destination choice [@bhat1998disaggregate;
@train1998recreation], route choice [@yai1997multinomial; @cascetta2002model;
@erhardt2003modeling; @gliebe2002model], air travel choices 
[@proussaloglou1999choice], activity analysis [@wen1999integrated] and auto ownership,
brand and model choice [@train1994dimensions; @bhat1998comparison].  Choice
models have also been applied in several other fields such as purchase incidence
and brand choice in marketing [@kalyanam1997incorporating; @bucklin1995brand],
housing type and location choice in geography [@waddell1993exogenous; @evers1990residential;
@william1998factor], choice of intercity air carrier [@proussaloglou1999choice] 
and investment choices of finance firms [@corres1993empirical].

## Application Context in Current Course

In this self-instructing course, we focus on the travel mode choice decision.
Within the travel demand modeling field, mode choice is arguably the single most
important determinant of the number of vehicles on roadways.  The use of
high-occupancy vehicle modes (such as ridesharing arrangements and transit)
leads to more efficient use of the roadway infrastructure, less traffic
congestion, and lower mobile-source emissions as compared to the use of
single-occupancy vehicles. Further, the mode choice decision is the most easily
influenced travel decision for many trips.  There is a vast literature on travel
mode choice modeling which has provided a good understanding of factors which
influence mode choice and the general range of trade-offs individuals are
willing to make among level-of-service variables (such as travel time and travel
cost).

The emphasis on travel mode choice in this course is a result of its important
policy implications, the extensive literature to guide its development, and the
limited number of alternatives involved in this decision (typically, 3 – 7
alternatives).  While the methods discussed here are equally applicable to cases
with many alternatives, a limited number of mode choice alternatives enable us
to focus the course on important concepts and issues in discrete choice modeling
without being distracted by the mechanics and presentation complexity associated
with larger choice sets.

## Urban and Intercity Travel Mode Choice Modeling

The mode choice decision has been examined both in the context of urban travel
as well as intercity travel.

### Urban Travel Mode Choice Modeling

Many metropolitan areas are plagued by a continuing increase in traffic
congestion resulting in motorist frustration, longer travel times, lost
productivity, increased accidents and automobile insurance rates, more fuel
consumption, increased freight transportation costs, and deterioration in air
quality.  Aware of these serious consequences of traffic congestion,
metropolitan areas are examining and implementing transportation congestion
management (TCM) policies.  Urban travel mode choice models are used to evaluate
the effectiveness of TCM policies in shifting single-occupancy vehicle users to
high-occupancy vehicle modes.

The focus of urban travel mode choice modeling has been on the home-based work
trip.  All major metropolitan planning organizations estimate home-based work
travel mode choice models as part of their transportation planning process.
Most of these models include only motorized modes, though increasingly
non-motorized modes (walk and bike) are being included [@lawton1989travel;
@purvis1997disaggregate].
	
The modeling of home-based non-work trips and non-home-based trips has received
less attention in the urban travel mode choice literature.  However, the
increasing number of these trips and their contribution to traffic congestion
has recently led to more extensive development of models for these trip purposes
in some metropolitan regions [for example, @iglesias1997estimation; @marshall1998new].
	
In this course, we discuss model-building and specification issues for
home-based work and home-based shop/other trips within an urban context, though
the same concepts can be immediately extended to other trip purposes and
locales.

### Intercity Mode Choice Models

Increasing congestion on intercity highways and at intercity air terminals has
raised serious concerns about the adverse impacts of such congestion on regional
economic development, national productivity and competitiveness, and
environmental quality.  To alleviate current and projected congestion, attention
has been directed toward identifying and evaluating alternative proposals to
improve intercity transportation services.  These proposals include expanding or
constructing new express roadways and airports, upgrading conventional rail
services and providing new high-speed ground transportation services using
advanced technologies.  Among other things, the a priori evaluation of such
large scale projects requires the estimation of reliable intercity mode choice
models to predict ridership share on the proposed new or improved intercity
service and identify the modes from which existing intercity travelers will be
diverted to the new (or improved) service.

Intercity travel mode choice models are usually segmented by purpose (business
versus pleasure), day of travel (weekday versus weekend), party size (traveling
individually versus group travel), etc.  The travel modes in such models
typically include car, rail, air, and bus modes [@koppelman1998nested; 
@bhat1998analysis; and @marwick1993florida].
	
This manual examines issues of urban model choice; however, the vast majority of
approaches and specifications can and have been used in intercity mode choice
modeling.

## Description of the Course

This self-instructing course (SIC) is designed for readers who have some
familiarity with transportation planning methods and background in travel model
estimation.  It updates and extends the previous SIC Manual [@horowitz1986self] 
in a number of important ways.  First, it is more rigorous in the
mathematical details reflecting increased awareness and application of discrete
choice models over the past decade.  The course is intended to enhance the
understanding of model structure and estimation procedures more so than it is
intended to introduce discrete choice modeling (readers with no background in
discrete choice modeling may want to work first with the earlier SIC).  Second,
this SIC emphasizes "hands-on" estimation experience using data sets obtained
from planning and decision-oriented surveys.  Consequently, there is more
emphasis on data structure and more extensive examination of model specification
issues.  

> Update: this manual uses the same models and data as the 2006 Bhat / Koppelman
SIC, but the models are executed in R, with the data available for download and 
the estimation code exposed to the reader.

Third, this SIC extends the range of travel modes to include
non-motorized modes and discusses issues involved in including such modes in the
analysis.  Fourth, this SIC includes detailed coverage of the nested logit model
which is being used more commonly in many metropolitan planning organizations
today.

## Organization of the Course Structure

This course manual is divided into twelve chapters or modules.  [CHAPTER 1](#chapter1), this
chapter, provides an introduction to the course. [CHAPTER 2][Elements of the Choice Decision Process] 
describes the elements of the choice process including the decision maker, the alternatives,
the attributes of the alternative, and the decision rule(s) adopted by the
decision maker in making his/her choice.  [CHAPTER 3][Utility-based Choice Theory] 
introduces the basic concepts of utility theory followed by a discussion of probabilistic and
deterministic choice concepts and the technical components of the utility
function.

[CHAPTER 4][The Multinomial Logit Model] describes the Multinomial Logit (MNL) 
Model in detail.  The discussion
includes the functional form of the model, its mathematical properties, and the
practical implications of these properties in model development and application.
The chapter concludes with an overview of methods used for estimating the model
parameters.
	
In [CHAPTER 5][Data Assembly and Estimation of Simple Multinomial Logit Models], 
we first discuss the data requirements for developing disaggregate
mode choice models, the potential sources for these data, and the format in
which these data need to be organized for estimation.  Next, the data sets used
in this manual, i.e., the San Francisco Bay Area 1990 work trip mode choice (for
urban area journey to work travel) and the San Francisco Bay Area Shop/Other
1990 mode choice data (for non-work travel),  are described.  This is followed
by the development of a basic work mode choice model specification. The
estimation results of this model specification are reviewed with a comprehensive
discussion of informal and formal tests to evaluate the appropriateness of model
parameters and the overall goodness-of-fit statistics of the model.
	
[CHAPTER 6][Model Specification Refinement] describes and demonstrates the 
process by which the utility function
specification for the work mode choice model can be refined using intuition,
statistical analysis, testing, and judgment.  Many specifications of the utility
function are explored for both data sets to demonstrate some of the most common
specification forms and testing methods.  Starting from a base model,
incremental changes are made to the modal utility functions with the objective
of finding a model specification that performs better statistically, and is
consistent with theory and our a priori expectations about mode choice behavior.
The appropriateness of each specification change is evaluated using judgment and
statistical tests.  This process leads to a preferred specification for the work
mode choice MNL model.
	
[CHAPTER 7][San Francisco Bay Area Shop / Other Mode Choice] parallels 
[CHAPTER 6][Model Specification Refinement] for the shop/other mode choice model.
	
[CHAPTER 8][Nested Logit Model] introduces the Nested Logit (NL) Model.  The Chapter 
begins with the motivation for the NL model to address one of the major limitations of the MNL.
The functional form and the mathematical properties of the NL are discussed in
detail.  This is followed by a presentation of estimation results for a number
of NL model structures for the work and shop/other data sets.  Based on these
estimation results, statistical tests are used to compare the various NL model
structures with the corresponding MNL.
	
[CHAPTER 9][Selecting a Preferred Nesting Structure] describes the issues involved 
in formulating, estimating and
selecting a preferred NL model. The results of statistical tests are used in
conjunction with our a priori understanding of the competitive structure among
different alternatives to select a final preferred nesting structure.  The
practical implications of choosing this preferred nesting structure in
comparison to the MNL model are discussed.

[CHAPTER 11][Aggregate Forecasting Assessment, and Application] describes how 
models estimated from disaggregate data can be used to
predict a aggregate mode choice for a group of individuals from relevant
information regarding the altered value (due to socio-demographic changes or
policy actions) of exogenous variables.  The chapter also discusses issues
related to the aggregate assessment of the performance of mode choice models and
the application of the models to evaluate policy actions.
	
[CHAPTER 12][Recent Advances in Discrete Choice Modeling] provides an overview 
of the motivation for and structure of advanced
discrete choice models. The discussion is intended to familiarize readers with a
variety of models that allow increased flexibility in the representation of the
choice behavior than those allowed by the multinomial logit and nested logit
models.  It does not provide the detailed mathematical formulations or the
estimation techniques for these advanced models. Appropriate references are
provided for readers interested in this information.
