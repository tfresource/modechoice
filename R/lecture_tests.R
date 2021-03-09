library(mlogit)
library(tidyverse)
library(modelsummary)

data("Fishing", package = "mlogit")
Fish <- dfidx(Fishing, varying = 2:9, shape = "wide", choice = "mode")

## a pure "conditional" model
mnl_pricecatch <- mlogit(mode ~ price + catch, data = Fish)

## a pure "multinomial model"
mnl_income  <- mlogit(mode ~ 0 | I(income/1000), data = Fish)


## both
mnl_both <- mlogit(mode ~ price + catch | I(income/1000), data = Fish)


models <- list(
  "Conditional" = mnl_pricecatch,
  "Multinomial" = mnl_income,
  "Both" = mnl_both
)

modelsummary(models, output = "markdown")

# likelihood ratio tests ==========
lrt_stat <- -2 * (logLik(mnl_income) - logLik(mnl_both))
dchisq(lrt_stat, 2)


ggplot(tibble(x = seq(0, 10, 0.01), chisq = dchisq(x, 2)),
       aes(x, y = chisq)) + 
  geom_line()


lrtest(mnl_income, mnl_both)


# tests on parameters ============
df <- nrow(Fish) - length(coef(mnl_pricecatch))
tibble(
  term = names(coef(mnl_pricecatch)),
  beta = coef(mnl_pricecatch),
  se = sqrt(diag(-1 * solve(mnl_pricecatch$hessian))),
  t = beta / se,
  p =2 * pt(abs(t), df,  lower.tail = FALSE)
)

broom::tidy(mnl_pricecatch)
