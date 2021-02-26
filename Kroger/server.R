library(shiny)
library(ggplot2)


#load in the data
load('KrogerHouseholdsCarbs.RData')
load('KrogerShiny.RData')

shinyServer(function(input, output) {

    output$scatter = renderPlot({
        Data <- subset(HOUSE,StateID == input$state)
        ggplot( aes(x=NumVisits,y=TotSpent),data = Data) +
            geom_point() +
            geom_smooth(method = "lm") +
            ggtitle("Total Spent vs Amount of Visits") +
            xlab("Number of Visits") +
            ylab("Total Spent") +
            theme(text=element_text(size=20))
        #plot(TotSpent ~ NumVisits, data=HOUSE)
    })
    
    output$table = renderDataTable({
        Table <- aggregate(Visits ~ Income,data=KROGER, FUN=mean)
        names(Table) <- c("Income Level", "Average # of Visits")
        Table
    })
    
    output$bar = renderPlot({
        Data <- subset(HOUSE, City == input$city)
        Data <- Data[,c("PancakeMoney", "PastaMoney", "SauceMoney", "SyrupMoney")]
        Data <- c(mean(Data$PancakeMoney), mean(Data$PastaMoney), mean(Data$SauceMoney), mean(Data$SyrupMoney))
        Data <- data.frame(
            Item=c("Pancakes", "Pasta", "Sauces", "Syrup"),
            AverageRevenue=round(Data,digits = 2)
        )
        
        ggplot(Data, aes(x=Item,y=AverageRevenue, fill=Item )) +
            geom_bar(stat = "identity") +
            ggtitle(paste("Average Revenue from Different Types of Products in",input$city)) +
            geom_text(aes(label=AverageRevenue), vjust=2, colour="white") +
            theme(text=element_text(size=20))
        
    })
    
    output$stats = renderPrint({
        Data2 <- subset(HOUSE,StateID == input$state2)
        data <- c()
        if("NumCoupons" %in% input$stat) {data <- c(data,sum(Data2$NumCoupons)) }
        if("NumVisits" %in% input$stat) {data <- c(data,sum(Data2$NumVisits)) }
        if("NumberOfStores" %in% input$stat) {data <- c(data,sum(Data2$NumberOfStores)) }
        
        Data2 <- data.frame(
            Interest=input$stat,
            Value=data
        )
        unique(Data2)
        #ggplot(Data2, aes(x=x,y=y,fill=x)) +
        #    geom_bar(stat = "identity") +
        #    ggtitle(paste("Basic Stats for all the households in", input$state2)) +
        #    geom_text(aes(label=y), vjust=2, colour="white") +
        #    theme(text=element_text(size=20))
        
    })
    
    

})
