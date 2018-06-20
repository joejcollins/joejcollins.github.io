---
layout: post
---
The Independent Press Standards Organisation (IPSO) publishes rulings for inaccuracy 2017.
<https://tabloidcorrections.wordpress.com/2018/01/02/statistics-show-that-daily-mail-was-by-far-the-most-unreliable-uk-paper-in-2017/>
Is there are relationship with circulation?
<https://en.wikipedia.org/wiki/List_of_newspapers_in_the_United_Kingdom_by_circulation#2010_to_present>

```R
Name <- c('The Sun','Daily Mail','Daily Mirror','Daily Telegraph','The Times','Daily Star','Daily Express')
Circulation <- c(1666715,1511357,724888,472258,	451261,443452,392526)
Rulings <- c(17,50,5,10,8,6,19)
Inaccuracy <- c(16,37,2,9,7,6,17)
Newspapers <- data.frame(Name, Circulation, Rulings, Inaccuracy)

plot(Newspapers$Circulation, Newspapers$Rulings, 
     main="Circulation and Rulings",
     xlab = "Circulation in thousands", xlim=c(350000, 1800000),
     ylab = "IPSO Rulings", ylim=c(0, 55),
     col="blue", pch=18)
abline(lm(Newspapers$Rulings ~ Newspapers$Circulation))
text(Circulation, Rulings, labels=Name, cex=0.7, pos=4)

cor.test(Newspapers$Rulings, Newspapers$Circulation, method="pearson")
```

Probably not.

![Scatter of Circulation and Rulings]({{ site.url }}/assets/circulation-and-inaccuracy.png)

    	Pearson's product-moment correlation
    
    data:  Newspapers$Rulings and Newspapers$Circulation
    t = 1.8623, df = 5, p-value = 0.1216
    alternative hypothesis: true correlation is not equal to 0
    95 percent confidence interval:
     -0.2183074  0.9400043
    sample estimates:
          cor 
    0.6399588 
