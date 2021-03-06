---
layout: post
---
Load the data this time from the first sheet of an Excel spreadsheet.

```R
require(XLConnect)
wb <- loadWorkbook("Book1.xlsx")
In <- readWorksheet(wb, sheet = "Sheet1", header = TRUE)
```

    Loading required package: XLConnect
    Loading required package: XLConnectJars
    XLConnect 0.2-13 by Mirai Solutions GmbH [aut],
      Martin Studer [cre],
      The Apache Software Foundation [ctb, cph] (Apache POI),
      Graph Builder [ctb, cph] (Curvesapi Java library)
    http://www.mirai-solutions.com ,
    http://miraisolutions.wordpress.com


Get number of columns in input matrix and define plot counter


```R
maxcol<- ncol(In)
counter=1
```

Define a data frame to take the accumulated quadrat species lists plus covers


```R
Out <- data.frame(x=integer(0), y=character(0), z=integer(0))
names(Out)[c(1,2,3)] <- c("Quadrat","Names","Cover")
```

Loop through matrix extracting each quadrat list and add to 'Out'


```R
for (col in 2:maxcol)
{ 
    Quadrat <- na.omit(In[,c(1,col)])
    Qid <-rep(counter, times=nrow(Quadrat))
    Quadrat <-cbind(Qid,Quadrat) 
    names(Quadrat)[c(1,2,3)] <- c("Quadrat","Names","Cover")
    Out <- rbind(Out,Quadrat)
    counter=counter+1
}
```

Write to space delimited txt file


```R
write.table(Out, "out-from-excel.txt", col.names=FALSE, row.names=FALSE, quote=FALSE)
```
