---
layout: post
---

Is the hotness related to size.

![Different Chillis]({{ site.url }}/assets/chillis.jpg)

Load the data.

```
{% include_relative how-hot-is-my-chilli/02-chillis.csv %}
```

Scatter plot and correlation

```R
{% include_relative how-hot-is-my-chilli/04-chillis.r %}
```

Results in this.

        Pearson's product-moment correlation

    data:  chillis$Hotness and chillis$Size.in.cm
    t = -4.2835, df = 28, p-value = 0.0001957
    alternative hypothesis: true correlation is not equal to 0
    95 percent confidence interval:
    -0.8066167 -0.3477465
    sample estimates:
        cor 
    -0.6291894 

So not much correlation.
