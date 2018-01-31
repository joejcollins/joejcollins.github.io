---
layout: post
---

Is the hotness related to size.

![Different Chillis]({{ site.url }}/assets/chillis.jpg)

Load the data.

```
{% include_relative how-hot-is-my-chilli/01-chillis.csv %}
```

Scatter plot and correlation. There seem to be some outliers, which I removed.
The correlation then goes up to 0.77.

```R
{% include_relative how-hot-is-my-chilli/02-chillis.r %}
```

![hotness and length]({{ site.url }}/assets/chillis-hotness-and-length.png)

![hotness and length]({{ site.url }}/assets/chillis-cooks-distance)

Results in this.

	Pearson's product-moment correlation

data:  chillis$hotness and chillis$size.in.cm
t = -6.3295, df = 26, p-value = 1.058e-06
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 -0.8925128 -0.5717768
sample estimates:
       cor 
-0.7787363 

So yeah, the small ones are hotter.
