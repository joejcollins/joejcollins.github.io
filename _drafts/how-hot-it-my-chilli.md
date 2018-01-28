---
layout: post
output: pdf_document
---

Load the data.

```{r import}
chillis <- read.csv(file="./how-hot-it-my-chilli/02-chillis.csv", header=TRUE, sep=",")
head(chillis, n=10)
plot(chillis$Hotness, chillis$Size.in.cm)
cor.test(chillis$Hotness, chillis$Size.in.cm, method="pearson")
```


