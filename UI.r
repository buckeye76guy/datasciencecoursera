# ui.R

shinyUI(fluidPage(
  titlePanel("Saving Costs And Stamps"),
  
  sidebarLayout(position = "right",
                sidebarPanel( fluidRow(
                  column(3, numericInput("cost", label = "Total Cost", value = 1, min = .21, max = 91)),
                  
                  column(3, checkboxInput("mix", label = "Mix $.49 & $.21", value = TRUE)),
                  
                  column(3, submitButton("Submit")
                  ))),
                mainPanel(
                  tableOutput("table1"),
                  p("This is a simple applet that is designed to make some work
                    a bit easier than normal. If you have a stack of stamps (some of them worth $.49
                    each and the rest $.21 each) and you 
                    have to mail an envelope whose weight indicates a certain 
                    cost, unless you have a way to print out labels I would
                    suggest giving this applet a try."),
                  p("Simply enter a cost in the box 'Total Cost' and click the Submit button."),
                  p("This User Interface was inspired by Attorney Leonard C. Bennett
                    @ 'Bennett & Bennett Law Group, LLC located at 4920 Niagara Road,
                    suite 206, college park, Maryland 20740. E: leonard@bblegal.net."),
                  p("Thank you and Have a wonderful day!")
                  )
  )
))
