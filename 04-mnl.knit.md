# The Multinomial Logit Model




## Overview Description and Functional Form

The mathematical form of a discrete choice model is determined by the assumptions made regarding the error components of the utility function for each alternative as described in section 3.5.  The specific assumptions that lead to the Multinomial Logit Model are (1) the error components are extreme-value (or Gumbel) distributed, (2) the error components are identically and independently distributed across alternatives, and (3) the error components are identically and independently distributed across observations/individuals.  We discuss each of these assumptions below.

The most common assumption for error distributions in the statistical and modeling literature is that errors are distributed normally.  There are good theoretical and practical reasons for using the normal distribution for many modeling applications.  However, in the case of choice models the normal distribution assumption for error terms leads to the Multinomial Probit Model (MNP) which has some properties that make it difficult to use in choice analysis.[^numericalproblems]  The Gumbel distribution is selected because it has computational advantages in a context where maximization is important, closely approximates the normal distribution (see Figure 4.1 and Figure 4.2) and produces a closed-form[^withoutnumint] probabilistic choice model.


```r
pdf <- tibble(
  x = seq(-5, 5, by = 0.01),
  Normal = dnorm(x, sd = sqrt(pi^2/6)),
  Gumbel = exp(-x) * exp(-exp(-x))
) 

ggplot(pdf %>% gather(key = "Distribution", value = "Probability", -x),
       aes(x = x, y = Probability, color = Distribution)) +
  geom_line() + 
  theme_bw()
```

<div class="figure">
<img src="04-mnl_files/figure-html/gumbelpdf-1.png" alt="Probability density function for normal and Gumbel distributions." width="672" />
<p class="caption">(\#fig:gumbelpdf)Probability density function for normal and Gumbel distributions.</p>
</div>


```r
cdf <- tibble(
  x = seq(-4, 5, by = 0.01),
  Normal = pnorm(x, sd = sqrt(pi^2 / 6)),
  Gumbel = exp(-exp(-x))
) 

ggplot(cdf %>% gather(key = "Distribution", value = "Probability", -x),
       aes(x = x, y = Probability, color = Distribution)) +
  geom_line() + 
  theme_bw()
```

<div class="figure">
<img src="04-mnl_files/figure-html/gumbelcdf-1.png" alt="Cumulative density function for normal and Gumbel distributions." width="672" />
<p class="caption">(\#fig:gumbelcdf)Cumulative density function for normal and Gumbel distributions.</p>
</div>

	
The Gumbel has the following cumulative distribution and probability density functions:

	
	
Where
	
	
	
The mean and variance of the distribution are:
	
	
	
The second and third assumptions state the location and variance of the distribution just as  and  indicate the location and variance of the normal distribution. We will return to the discussion of the independence between/among alternatives in CHAPTER 8. 
	
The three assumptions, taken together, lead to the mathematical structure known as the Multinomial Logit Model (MNL), which gives the choice probabilities of each alternative as a function of the systematic portion of the utility of all the alternatives.  The general expression for the probability of choosing an alternative ‘*i*’ (*i = 1,2,.., J*) from a set of *J* alternatives is:
	
	
	
Where
	
	
	
The exponential function is described in Figure 4.3 which shows the relationship between   and  .  Note that   is always positive and increases monotonically with  .











