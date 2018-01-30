chillis <- read.csv(file="./02-chillis.csv", header=TRUE, sep=",")
plot(chillis$hotness, chillis$size.in.cm, 
     main="Hotness and Size",
     xlab = "Hotness", xlim=c(0, 10),
     ylab = "Length in cm", ylim=c(0, 16),
     col="blue", pch=18)
abline(lm(chillis$hotness ~ chillis$size.in.cm))
text(chillis$hotness, chillis$size.in.cm, labels = chillis$name, cex=0.7, pos=4)
cor.test(chillis$hotness, chillis$size.in.cm, method="pearson")
