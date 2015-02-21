---
title       : Predict Coin Flips
subtitle    : 
author      : Noor Ahmed
job         : Data products assignment 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
url:
  lib: ../../libraries
  assets: ../../assets
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained  # {standalone, draft}
knit        : slidify::knit2slides

---

## Flip a Coin!

Just imagine a friend asks you to bet on the outcome of some coin flips. And you prefered to bet on a series of coin flips at once.  Each time the coin is heads, you receive the payout and if the coin is tails your friend receives the payout. 

<img class = center src=./assets/img/coin_flip_s.jpg height=300 Width=300> 

Now, Let us explore the probabilities of wins and losses with a fair coin and also the payouts between you and your friend!

---
## Prediction Approach 
To predict the results, I have used four input variables as listed below:
#### Input values/variables: 
1. Payout($) for you on every win 
2. Payout($) for your friend on every win
3. Number of repeats per trail
4. Number of trails
5. Is the Coin Fair? or Biased?

#### Libraries used:
1. library(shiny)
2. library(ggplot2)
3. library(eeptools)

---
## Processing:

```r
source("../server.R")
```

```
## Warning in file(filename, "r", encoding = encoding): cannot open file
## '../server.R': No such file or directory
```

```
## Error in file(filename, "r", encoding = encoding): cannot open the connection
```

```r
source("../ui.R")
```

```
## Warning in file(filename, "r", encoding = encoding): cannot open file
## '../ui.R': No such file or directory
```

```
## Error in file(filename, "r", encoding = encoding): cannot open the connection
```

#### ui.R code snippet [for slider inputs using shiny]

```r
# Slider input to set expected Payout value for You on every win
sliderInput("value","Payout($) to Me for every win", value=5, min=5, max=50),
# Slider input to set expected Payout value for Your friend
sliderInput("bet","Payout($) to my Friend for every win", value=5, min=5, max=50),
# Slider to provide the input for number of simulations/repeats
sliderInput("reps","Number of repeats per trial:", 
            value= 50, min=5, max=100, step=5, animate=TRUE),
# Slider to provide the input for number of trials 
sliderInput("obs","Number of trials:", 
            value=50, min=50, max=200, step=10, animate=TRUE),
# Slider to provide the input for Fairness of the coin with step increment
sliderInput("coin","Fairness of the coin:", 
            value=0.0, min=-.50, max=.50, step=0.05, animate=TRUE),
```

---
## Processing: 
#### server.R code snippet  [for prediction logic using shiny server]

```r
shinyServer(function(input,output) {
    trialInput <- reactive(function() { bias <- input$coin
        sims   <- input$obs
        reps   <- input$reps
        trials <- rbinom(reps,sims,0.5+bias)  })
    # Expressions to generate the net wins plot.
    output$netwinsplot <- reactivePlot(function(){ trials <- trialInput()
     df2<- data.frame(wins=trials, you=trials*input$value, friend=(input$obs-trials)*input$bet)
        df2$net <- df2$you - df2$friend
        p  <- qplot(net,data=df2) + theme_dpi()
        print(p)  })
    # Expressions to generate the payoff plot.
    output$payoffsplot <- reactivePlot(function(){ trials <- trialInput()
        df  <- data.frame(actor=rep(c("Me","MyFriend"), each=input$reps),
                payout=c(trials*input$value,(input$obs-trials)*input$bet))
        p <- qplot(payout,data=df, geom='bar') + facet_wrap(~actor) + coord_flip() + 
            scale_x_continuous(label=dollar)
        print(p) }) })
```

---
## Prediction Results:

<img src=./assets/img/coin_flip_shinyapp.png height=500 width=800 >

Shiny application can be accessed at https://dsnoor.shinyapps.io/PredictCoinFlips/
