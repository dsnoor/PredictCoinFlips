# Load required libraries
library(shiny)
library(ggplot2)
library(eeptools)
# Define UI for application
shinyUI(fluidPage(
    # Application title
    titlePanel("Flip Coin Prediction App"),
    # Sidebar with number of slider inputs to make the predictions
    sidebarLayout(
        sidebarPanel(
            h4(helpText('Prediction Scenario:',style="color:blue")),
            helpText('Just imagine a friend asks you to bet on the outcome of some coin flips. And you prefered to bet 
                     on a series of coin flips at once. Basic rule is that each time the coin is heads, 
                     you receive the payout and if it is tails your friend receives the payout. 
                     Now Predict your wins and the payouts between you and your friend.', style ="color:black"),
            
            helpText("Let us explore the probability of the payouts with both fair and baised coin",style="color:blue"),          
            # Slider input to set expected Payout value for You on every win
            sliderInput("value","Payout($) to Me for every win", value=5, min=5, max=50),
            # Slider input to set expected Payout value for Your friend
            sliderInput("bet","Payout($) to my Friend for every win",value=5, min=5, max=50),
            # Slider to provide the input for number of simulations/repeats with default repeat as 100
            sliderInput("reps","Number of repeats per trial:", value= 50, min=5, max=100, step=5, animate=TRUE),
            # Slider to provide the input for number of trials with values between 50 and 200 and default value as 50
            sliderInput("obs","Number of trials:", value=50, min=50, max=200, step=10, animate=TRUE),
            # Slider to provide the input for Fairness of the coin with step increment
            sliderInput("coin","Fairness of the coin:", value=0.0, min=-.50, max=.50, step=0.05, animate=TRUE),
            h6(helpText('Note: Value set to 0 is considered as fair coin, any other value will be treated as baised.', style="color:purple")),
            br(),
            h4(helpText("How to Use this App:", style="color:blue")),
            helpText("Method 1. You can set the required values by using sliders, and the reactive result will be seen in the plots", style="color:black"),
            helpText("     (OR)    "),
            helpText("Method 2. Select all required values using sliders and then click on little tiny play button (available on the right end of each slider) 
                     to predict the results accordingly with an incremental changes to only one variable", style="color:black") 
            ),
        # Show the plots of the predicted results using ggplot2
        mainPanel(              
            h4("Predicted Wins"),
            plotOutput("netwinsplot"),
            h4("Predicted payoffs"),
            plotOutput("payoffsplot")
    ))
))  