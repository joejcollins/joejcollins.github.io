chillis <- read.csv(file="./02-chillis.csv", header=TRUE, sep=",")
plot(chillis$Hotness, chillis$Size.in.cm, 
     main="Hotness and Size",
     xlab = "Hotness", xlim=c(0, 10),
     ylab = "Length in cm", ylim=c(0, 16),
     col="blue", pch=18)
abline(lm(chillis$Hotness, chillis$Size.in.cm))
text(Hotness, Rulings, cex=0.7, pos=4)
cor.test(chillis$Hotness, chillis$Size.in.cm, method="pearson")