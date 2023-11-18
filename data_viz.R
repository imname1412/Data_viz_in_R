# get working directory
getwd()

### Native plot ###
# EDA graphical & numerical
hist(mtcars$hp) # right skew
mean(mtcars$hp)
median(mtcars$hp)

# review
glimpse(mtcars)
str(mtcars)

# change data type -> factor (gearing 1 / 0 auto or not)
mtcars$am <- factor(mtcars$am,
                    levels = c(0, 1),
                    labels = c("Auto", "Manual"))

# One qualitative variable
table(mtcars$am) # frequency
barplot(table(mtcars$am))

# box plot
boxplot(mtcars$hp)
fivenum(mtcars$hp) # 52  96 123 180 335 -> min Q1 Q2(median) Q3 max respectively
quantile(mtcars$hp, probs = c(0.25, 0.5, 0.75))
# Whisker 
# Q3 + 1.5*IQR to consider the outlier
Q3 <- quantile(mtcars$hp, probs = .75)
Q1 <- quantile(mtcars$hp, probs = .25)
IQR_hp <- Q3 - Q1

boxplot.stats(mtcars$hp, coef = 1.5)

# filter
mtcars_no_outs <- mtcars %>%
  filter(hp < 335)

boxplot(mtcars_no_outs$hp)

# Boxplot 2 variable y ~ x
boxplot(data=mtcars, mpg ~ am, col= c('green', 'salmon'))


# scatter plot
plot(mtcars$hp, mtcars$mpg, 
     pch= 15, 
     col='blue',
     main='Relationship between hp and mpg',
     xlab='horse power',
     ylab='miles per gallon'
     )
cor(mtcars$hp, mtcars$mpg) # -0.7761684
lm(mpg ~ hp, data=mtcars) # y = -0.06823 * x + 30.09886

