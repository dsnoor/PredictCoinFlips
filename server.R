# load required libraries
library(shiny)
library(scales)

# Define server logic required to process and draw the plots
shinyServer(function(input,output) {
    trialInput <- reactive(function() {
        bias   <- input$coin
        sims   <- input$obs
        reps   <- input$reps
        trials <- rbinom(reps,sims,0.5+bias)
    })
    
    # Expressions to generate the net plot.
    output$netwinsplot <- reactivePlot(function(){
        trials  <- trialInput()
        df2     <- data.frame(wins=trials, you=trials*input$value, friend=(input$obs-trials)*input$bet)
        df2$net <- df2$you - df2$friend
        p       <- qplot(net,data=df2) + theme_dpi()
        
        # draw the netplot based on the specified values 
        print(p)
    })
    
    # Expressions to generate the payoff plot.
    output$payoffsplot <- reactivePlot(function(){
        trials <- trialInput()
        
        df  <- data.frame(actor=rep(c("Me","MyFriend"),
                                    each=input$reps),
                          payout=c(trials*input$value,(input$obs-trials)*input$bet))
        
        p   <- qplot(payout,data=df, geom='bar') + facet_wrap(~actor) + coord_flip() + 
            scale_x_continuous(label=dollar)
        
        # draw the payoff plots based on the specified values
        print(p)
    })
    
})