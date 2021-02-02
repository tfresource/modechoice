--- 
title: "A Self-Instructing Course in Mode Choice Modeling"
date: "2021-02-02"
site: bookdown::bookdown_site
author:
  - name: "Frank Koppelman"
    affiliation: "Northwestern University (Emeritus)"
  - name: "Chandra Bhat"
    affiliation: "University of Texas as Austin"
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
description: "This is a minimal example of using the bookdown package to write a book. The output format for this example is bookdown::gitbook."
---

# Foreword {-}

<img src="img/cover.jpg" width="50%" style="display: block; margin: auto;" />


This is a re-publication of [A Self-Instructing Course in Mode Choice Modeling](https://trid.trb.org/view/793000),
originally prepared by Frank Koppelman and Chandra Bhat for the Federal Transit
Administration.
The mathematics and instruction provided by this course have been extraordinarily
helpful to a generation of choice modelers and other transportation
professionals in academic and practical settings. 

The explosion of open-source packages for logit modeling and literate
programming more generally warrants this re-publication in a programming-first
context. The R code to compute the choice models in this book is embedded within
the text and exposed to the viewer. In this way, the book serves not only as a
primer on choice modeling, but on how to estimate and interpret choice modelers
in R. This conversion project was undertaken by members of the AEP50(5)
subcommittee on Travel Forecasting Resources on behalf of the transportation
modeling community. The committee was aided in this conversion by the following
students at Brigham Young University:

Cover Photo: King's Cross Station, London by [Michał Parzuchowski](https://unsplash.com/@mparzuchowski) 
on [Unsplash](https://unsplash.com/collections/8484088/)

## Original Acknowledgements {-}
This manual was prepared under funding of the United States Department of Transportation
through the Federal Transit Administration (Agmt. 8-17-04-A1/DTFT60-99-D-4013/0012) to
AECOMConsult and Northwestern University. 

Valuable reviews and comments were
provided by students in travel demand modeling classes at Northwestern
University and the Georgia Institute of Technology. In addition, valuable
comments, suggestions and questions were given by Rick Donnelly, Laurie Garrow,
Joel Freedman, Chuck Purvis, Kimon Proussaloglou, Bruce Williams, Bill Woodford
and others. The authors are indebted to all who commented on any version of this
report but retain responsibility for any errors or omissions.


## R Packages {-} 

In order to run the examples in this book, you will need the following packages:


```r
install.packages("tidyverse") # data munging and plots
install.packages("mlogit") # choice model estimation
```


In order to build the book for yourself, you will need the following additional
packages that help build the tables and document:


```r
install.packages("bookdown")
install.packages("distill")
install.packages("modelsummary")
```







