# get library
# ggplot2
# -> data, mapping, geometry
library(tidyverse)


head(mtcars)
# scatter
ggplot(data=mtcars, mapping=aes(x=hp, y=mpg)) +
  geom_point() +
  geom_smooth() +
  geom_rug()

ggplot(mtcars, aes(hp, mpg)) +
  geom_point(size=3, alpha=0.4, col='red')

# hist.
ggplot(mtcars, aes(hp)) +
  geom_histogram(bins=10, fill='salmon')

# instance 1 var plot
based_plt <- ggplot(mtcars, aes(hp))

based_plt + geom_boxplot()
based_plt + geom_density()

## 2 variable
diamonds %>%
  count(cut)

glimpse(diamonds)
# bar
ggplot(diamonds, aes(cut, fill=color)) + 
  geom_bar(position='stack') # `stack`, `dodge`, `fill`

# scatter plot
# for large data set can sample it to show
set.seed(42)
samp <- sample_n(diamonds, 5000)

ggplot(samp, aes(carat, price, col=cut)) +
  geom_point(alpha=0.6)

# facet
ggplot(samp, aes(carat, price, col=color)) +
  geom_point(alpha=0.5) +
  geom_smooth(method = 'lm', col='orange') +
  facet_wrap(~cut, ncol=2) +
  labs(
    title='Relationship between carat and price by cut',
    x='Carat',
    y='Price (USD)',
    caption='ggplot2 pc.dev'
  ) +
  theme_minimal()



