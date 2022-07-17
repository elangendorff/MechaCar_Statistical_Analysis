# MechaCar_Statistical_Analysis

## Linear Regression to Predict MPG

Using the `MechaCar_mpg.csv` dataset, we created a linear model for the dataset's columns[^linear_model], and stored the result as `mpg_lm`.

[^linear_model]: using `lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data=mcmpg)`

### Results

`mpg_lm` showed the following output:

``` markdown
Coefficients:
     (Intercept)    vehicle_length    vehicle_weight     spoiler_angle  ground_clearance               AWD
      -1.040e+02         6.267e+00         1.245e-03         6.877e-02         3.546e+00        -3.411e+00
```

<br>

A summary of `mpg_lm` (generated by running `summary(mpg_lm)`) showed the following output:

``` markdown
Residuals:
     Min       1Q   Median       3Q      Max 
-19.4701  -4.4994  -0.0692   5.4433  18.5849 

Coefficients:
                   Estimate Std. Error t value Pr(>|t|)    
(Intercept)      -1.040e+02  1.585e+01  -6.559 5.08e-08 ***
vehicle_length    6.267e+00  6.553e-01   9.563 2.60e-12 ***
vehicle_weight    1.245e-03  6.890e-04   1.807   0.0776 .  
spoiler_angle     6.877e-02  6.653e-02   1.034   0.3069    
ground_clearance  3.546e+00  5.412e-01   6.551 5.21e-08 ***
AWD              -3.411e+00  2.535e+00  -1.346   0.1852    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 8.774 on 44 degrees of freedom
Multiple R-squared:  0.7149,    Adjusted R-squared:  0.6825 
F-statistic: 22.07 on 5 and 44 DF,  p-value: 5.35e-11
```

### Analysis

In the `Pr(>|t|)` column, we see the probability that the contribution of each factor toward the vehicles' `mpg` ratings is a result of random chance.

Three of the factors—`vehicle_length` (*p*-value = 2.60×10<sup>-12</sup>), `vehicle_weight` (*p*-value = 0.0776), and `ground_clearance` (*p*-value = 5.21×10<sup>-08</sup>)—show small or very small probabilities that their contributions are random, which indicates that they might have non-negligible effects on `mpg`.

The `(Intercept)` also shows statistical significance (*p*-value = 5.08×10<sup>-08</sup>), meaning that it explains a significant amount of variability in `mpg` when all the other examined factors (independent variables) are 0.

Given the presence of statistically significant slope factors in the linear model, we can reject the claim that the linear model has a slope of zero (null hypothesis <code>H<sub>0</sub>: <i>m</i> = 0</code>), and conclude that it more-than-likely has a non-zero slope (alternative hypothesis <code>H<sub>1</sub>: <i>m</i> ≠ 0</code>).

The model's *`R²`* value of 0.7149 indicates a strong degree of correlation between the factors, and so this model appears to be a reasonably good predictor of MechaCar protypes' `mpg` values.

## Summary Statistics on Suspension Coils

### Results

Summarizing the PSI data from the `Suspension_Coil.csv` file yielded the following results, overall:

``` markdown
   Mean Median Variance    SD
  <dbl>  <dbl>    <dbl> <dbl>
1 1499.   1500     62.3  7.89
```

<br>

Broken down by manufacturing lot, the results were:

``` markdown
  Manufacturing_Lot  Mean Median Variance     SD
  <chr>             <dbl>  <dbl>    <dbl>  <dbl>
1 Lot1              1500   1500     0.980  0.990
2 Lot2              1500.  1500     7.47   2.73 
3 Lot3              1496.  1498.  170.    13.0
```

### Analysis

We are asked to determine whether the current manufacturing data meet the design specification for all manufacturing lots in total and for each individual lot according to the following specification:  

> The variance of the suspension coils must not exceed 100 pounds per square inch.

<br>

We first note that the specification is malformed[^bad_spec], and presume that what is means to say is:  

> The variance of the suspension coils' PSI values must not exceed 100 \[units left unstated\].

[^bad_spec]: We know this because variance is a *squared* measure, and therefore its units would also be the square of the units of the data it aggregates. In the case of data measured in PSI—pounds per square inch—the units of the variance statistic would be in PSI² (or square pounds per quartic inch), not PSI.

<br>

With a value of 62.3, the coils' overall PSI-variance is indeed less than 100 (as required by the specification). However, while Lot1's and Lot2's variances are well below the limit—at 0.98 and 7.47, respectively—Lot3's variance comes in at 170—well above the limit.

Given how different Lot3 is from Lot1 and Lot2, AutosRUs might want to reexamine the manufacturing processes for Lot3 to determine whether those processes can be adjusted to improve their coils' consistency.

## T-Tests on Suspension Coils

For the manufactured suspension coils as a whole, and for each manufacturing lot, we wanted to test the claim that the set's mean PSI (<code><i>x&#x0304;</i></code>, or "mean of *x*") is statistically different from the (supplied, known) population mean (*`μ`*) of 1,500 pounds per square inch (modeled by alternative hypothesis <code>H<sub>1</sub>: <i>x&#x0304;</i> ≠ <i>μ</i></code>).  
\[The counterclaim—that the set's mean PSI is *not* statistically different from the population mean—is modeled by the null hypothesis <code>H<sub>0</sub>: <i>x&#x0304;</i> = <i>μ</i></code>.\]

### Results

Using R, we ran 2-tailed *t*-tests against the null hypotheses for each set, with the following outputs:

#### Overall
``` markdown
	One Sample t-test

data:  mcsc$PSI
t = -1.8931, df = 149, p-value = 0.06028
alternative hypothesis: true mean is not equal to 1500
95 percent confidence interval:
 1497.507 1500.053
sample estimates:
mean of x 
  1498.78
```

#### Lot1
``` markdown
	One Sample t-test

data:  subset(mcsc, Manufacturing_Lot == "Lot1")$PSI
t = 0, df = 49, p-value = 1
alternative hypothesis: true mean is not equal to 1500
95 percent confidence interval:
 1499.719 1500.281
sample estimates:
mean of x 
     1500
```

#### Lot2
``` markdown
	One Sample t-test

data:  subset(mcsc, Manufacturing_Lot == "Lot2")$PSI
t = 0.51745, df = 49, p-value = 0.6072
alternative hypothesis: true mean is not equal to 1500
95 percent confidence interval:
 1499.423 1500.977
sample estimates:
mean of x 
   1500.2
```

#### Lot3
``` markdown
	One Sample t-test

data:  subset(mcsc, Manufacturing_Lot == "Lot3")$PSI
t = -2.0916, df = 49, p-value = 0.04168
alternative hypothesis: true mean is not equal to 1500
95 percent confidence interval:
 1492.431 1499.849
sample estimates:
mean of x 
  1496.14
```

#### Summary of p-values for each test

| Lot      | p-value |
| ---      | ---     |
| Overall: | 0.06028 |
| Lot1:    | 1       |
| Lot2:    | 0.6072  |
| Lot3:    | 0.04168 |

---

### Analysis

From this, we find that under almost no metric (*i.e.*, for almost no value of significance level *`α`*) would we ever reject the null hypothesis <code>H<sub>0</sub></code> for either Lot1 or Lot2.

For Lot3, and for the overall sample, whether we can reject the null hypothesis <code>H<sub>0</sub></code> (and therefore conclude that <code>H<sub>1</sub></code> is true) depends on the significance level *`α`* we are willing to use.

At a common significance level of <code><i>α</i> = 0.05</code>, we would *not* reject <code>H<sub>0</sub></code> for the overall sample (because its *p*-value <code>0.06028 ≥ <i>α</i></code>), but we *would* reject <code>H<sub>0</sub></code> for Lot3 (because its *p*-value <code>0.04168 < <i>α</i></code>), and thus conclude that Lot3's mean PSI *is* statistically different from the population mean *`μ`* of 1,500 PSI. (If <code><i>α</i> ≤ 0.04168</code>, we would not reject <code>H<sub>0</sub></code> for *any* of the samples.)

In short, if we presume a significance level of <code><i>α</i> = 0.05</code>, then *only* for Lot3 may we reasonably conclude that the sample mean differs significantly from the population mean.

## Study Design: MechaCar vs Competition

Fuel efficiency and stability is all well and good, but nobody wants to buy a car that struggles to get up a hill. So it might also be a good idea to pit MechaCar's power (`hp`) against that of other cars in its class.

### The Claim

AutosRUs would surely like to support the claim that MechaCar's average (mean) horsepower (<code><i>x&#x0304;</i><sub>MC</sub></code>) exceeds that of its competition (<code><i>x&#x0304;</i><sub>comp</sub></code>).

### The Hypotheses

The above claim is modeled by the alternative hypothesis <code>H<sub>1</sub>: <i>x&#x0304;</i><sub>MC</sub> > <i>x&#x0304;</i><sub>comp</sub></code>, and its counter-claim—"MechaCar's average horsepower *does not* exceed that of its competition"—is modeled by the null hypothesis <code>H<sub>0</sub>: <i>x&#x0304;</i><sub>MC</sub> ≤ <i>x&#x0304;</i><sub>comp</sub></code>.

### The Requirements

In order to conduct the test, we will need sample `hp` data, both from MechaCar and from its competition, subject to the following constraints:  
1. The data must be numerical and continuous.  
   \[Horsepower (`hp`) is a continuous, numerical measure, so this is a given.\]
2. Each sample's data must be randomly selected from its population.  
   \[Ideally, we would want a [*simple* random sample][simple random sample], but that's not always feasible.\]
3. The data must be (approximately) normally distributed.  
   \[Since we are considering testing sample means, the [Central Limit Theorem] guarantees this, provided our sample sizes are large enough.\]
4. The sample sizes should be sufficiently large that their distributions approximate those of their respective populations.  
   \[This will also help to ensure that the requirements of the [Central Limit Theorem] are met.\]
5. The variances of the two samples should be very similar.  
   \[This will have to be checked once the samples are collected.\]

[simple random sample]: https://www.statisticshowto.com/probability-and-statistics/statistics-definitions/simple-random-sample/

[Central Limit Theorem]: https://www.statisticshowto.com/probability-and-statistics/normal-distributions/central-limit-theorem-definition-examples/

### The Test

Assuming all the above can be satisfied, we would then enter the two samples' `hp` data into a 1-tailed *t*-test (with `alternative = "greater"`).

Given the low stakes involved in the outcome of such a test (*i.e.*, it's unlikely that being wrong will result in dire consequences), we likely do not require a significance level any lower than <code><i>α</i> = 0.05</code>.