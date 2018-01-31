# Load the chillis and take a look
chillis <- read.csv(file="./01-chillis.csv", header=TRUE, sep=",")
plot(chillis$hotness, chillis$size.in.cm, 
     main="Hotness and Size",
     xlab = "Hotness", xlim=c(0, 10),
     ylab = "Length in cm", ylim=c(0, 25),
     col="blue", pch=18)
abline(lm(chillis$hotness ~ chillis$size.in.cm))
text(chillis$hotness, chillis$size.in.cm, labels = chillis$name, cex=0.7, pos=4)
# What is the correlation?
cor.test(chillis$hotness, chillis$size.in.cm, method="pearson")

# Maybe we should remove outliers using Cooks distance
mod <- lm(chillis$hotness ~ chillis$size.in.cm, data=chillis)
cooksd <- cooks.distance(mod)
plot(cooksd, pch="*", cex=2, main="Influential Obs by Cooks distance") 
abline(h = 4*mean(cooksd, na.rm=T), col="red")
text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>4*mean(cooksd, na.rm=T),names(cooksd),""), col="red")
influential <- as.numeric(names(cooksd)[(cooksd > 4*mean(cooksd, na.rm=T))])  # influential row numbers

# Remove the influential and check the correlation
chillis <- chillis[-influential,]
cor.test(chillis$hotness, chillis$size.in.cm, method="pearson")
