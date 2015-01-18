shinyServer(function(input, output) {
  
  How_Many <- function(x,y,cost){ #When mix is true
    vec <- numeric(2)
    vec1 <- numeric(2)
    vec2 <- numeric(2)
    cst <- function(a,b){abs(cost - (.49*a+.21*b))} #How far below or above the cost
    ERR <- cst(0,0)
    ERR1 <- cst(0,0)
    
    for (i in x) { #Here we loop through nbers of 49 cents stamps and find out what 
                    #nber of 21 cents stamps makes a good match
      for (j in y){
        if (cst(i,j) < ERR) {
          vec1 <- c(i,j)
          ERR <- cst(i,j)
        }
      }
    }
    for (k in y) { #Here we do the inverse.
      for (l in x){
        if (cst(l,k) < ERR1) {
          vec2 <- c(l,k)
          ERR1 <- cst(l,k)
        }
      }
    }
    #Here we find out which pair of nber of stam from each type contains less stamps in total
  if (vec1[1]+vec1[2] < vec2[1]+vec2[2]) { #Once I noticed that you could use 35 $.21
    #stamps or 15 $.49 stamps for the same cost of $7.35 I inversed the loop and only
    #registered the smalles amout of stamps needed.
    vec <- vec1
  } else { vec <- vec2}
  vec    
  }
  
  How_Many_1 <- function(x,y,cost) { #When they do not wish to mix stamps
    G_vec <- numeric(2) #Global vec, keeps nbers of each stamp
    vec1 <- 0 #Nber of 49 cents stamps
    vec2 <- 0 #Nber if 21 cents stamps
    cst <- function(a,b){abs(cost - (.49*a+.21*b))} #Comment just as above
    ERR <- cst(0,0) 
    ERR1 <- cst(0,0)
    for (i in x) {
      if (cst(i,0) < ERR) { #Notice the y coordinate is always 0, that is because
                            #we only want 49 cents stamps here and we still want to use the cst function
        vec1 <- i
        ERR <- cst(i,0)
      }
    }
    for (j in y) {
      if (cst(0,j) < ERR1) { #Notice the x coordinate always 0, same reason as above expt: 21 cents stamps
        vec2 <- j
        ERR1 <- cst(0,j)
      }
    }
    G_vec <- c(vec1, vec2)
    G_vec
  }
  
  output$table1 <- renderTable({
    x <- 0:100 #Number of 49 cents stamps
    y <- 0:200 #Number of 21 cents stamps
    if (!is.numeric(input$cost)) { #If they did not enter a number as cost, return a warning
      warn <- data.frame(Warning = "Please Enter a NUMBER BETWEEN .21 AND 91")
      return(warn)
    }
    if (input$mix){ #When they want to mix stamp types, give them a table with combos of type of stamps
      if (input$cost > 91 | input$cost < .21) {data.frame(Error = "You Should Probably Go To The Post Office!")}
      else {z <- How_Many(x,y,input$cost)  
      data.frame(Nber_of_49_cents_Stamps = z[1], Nber_of_21_cents_Stamps = z[2],
                 Total = paste("$", .49*z[1]+.21*z[2], sep = " "))
    }} else { #If they do not wish to mix stamp types, show them how many of each kind they need
      x <- 0:100
      y <- 0:200
      if (input$cost > 42) {data.frame(Error = "You Should Definitely Mix Stamps")}
      else { G_z <- How_Many_1(x,y,input$cost)
        data.frame(Nber_of_49_cents_Stamps = G_z[1], Total = paste("$", .49*G_z[1],
                   sep = " "), Nber_of_21_cents_Stamps = G_z[2],
        Totals = paste("$", .21*G_z[2], sep = " "))}
    }
    
  })
})
