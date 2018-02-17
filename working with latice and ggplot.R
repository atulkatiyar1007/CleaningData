## ggplot2 practice
# install ggplot2 package
### Working with lattice graphical packages ############
library(nlme)
library(lattice)

str(BodyWeight)
head(BodyWeight)

xyplot(weight ~ Time | Diet, BodyWeight, panel = function( weight, Time, ...)
  {
  panel.xyplot(weight, Time)
  panel.abline(h = median(weight) ) } 
)

panel.line

p <- xyplot(Ozone ~ Wind | factor(Month), data = airquality)


#### ggplot2

install.packages('ggplot2')

library(ggplot2)
data(mpg)

qplot( Wind, Ozone, data= airquality , facets= .~factor(Month))

library(ggplot2)


data(movies)

g <- ggplot(movies, aes(votes, rating))
print(g)




str(mpg)
qplot(displ, hwy, data=mpg, col=drv)

qplot( displ, hwy, data = mpg,geom = c("point", "smooth"))

qplot(hwy, data=mpg, fill= drv, binwidth= 2)

qplot( displ, hwy, data= mpg, facets = .~drv)

qplot( trans, cty , data= mpg, facets = cyl~.)

data("PlantGrowth")
str(PlantGrowth)

data("ChickWeight")
str(ChickWeight)

head(ChickWeight)


urlk <- "https://data.baltimorecity.gov/api/views/59fg-ary5/rows.csv?accessType=DOWNLOAD"
download.file(url=urlk, destfile="./data/crime.csv", method="auto", mode="wb")

crimeData <- read.csv("./data/crime.csv", fill=TRUE )

head(crimeData)


rm( list = ls())

data("airquality")

str(airquality)


g <- ggplot( data = airquality, mapping = aes( Ozone, Solar.R))
class(g)
str(g)
dim(airquality)

var <- rep( c( "r", "k "), each=74)
fac_var <- factor(var, labels= c('atul', "gunjan"))
fac_var
fac_var <- fac_var[1:153]
air <- cbind( fac_var, airquality)
str(air)

g <- ggplot(data = air , mapping = aes(Ozone, Wind))

g + geom_point(color = "blue", alpha = 1/3, size= 2) + facet_grid( .~fac_var)
g + geom_point(color = "blue", alpha = 1/3, size= 2) + facet_grid( .~fac_var) +
  geom_smooth( color='red', linetype = 3, size=2,method = "lm")


cutpoints <- quantile( air$Wind, seq( 0, 1 ,length= 4), na.rm = TRUE)
cutpoints

air$WindCat <- cut(air$Wind, cutpoints)
air$WindCat

str(air)

facet

g <- ggplot( data = air, mapping = aes( Solar.R, Ozone ))

g + geom_point( color = 'steelblue', size= 2, alpha= 1/3) + 
  facet_grid ( WindCat ~ fac_var ) + 
  geom_smooth(linetype=2, size= 1, color="red" ,method = "lm", se= FALSE) +
  theme_bw ( base_size = 11, base_family = "Times") +
  labs( title = "First ggplot") +
  labs ( x = expression( "log" * PM[2.5])) +
  labs( y = "Ozone ")

