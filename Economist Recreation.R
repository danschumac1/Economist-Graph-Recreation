#Import the ggplot2 data.table libraries and use fread to load the csv file 'Economist_Assignment_Data.csv' 
#into a data frame called df (Hint: use drop=1 to skip the first column)

library(ggplot2)
library(data.table)

help('fread')
df <-fread(file='Economist_Assignment_Data.csv',drop=1)

#Check the head of df
head(df)

#Use ggplot() + geom_point() to create a scatter plot object called pl. 
#You will need to specify x=CPI and y=HDI and color=Region as aesthetics

pl <- ggplot(df,aes(x=CPI,y=HDI,color=Region))
pl + geom_point()

#Change the points to be larger empty circles. 
#(You'll have to go back and add arguments to geom_point() and reassign it to pl.) 
#You'll need to figure out what shape= and size=

pl <- ggplot(df,aes(x=CPI,y=HDI,color=Region))
pl <- pl + geom_point(shape=1,size=5)
pl


#Add geom_smooth(aes(group=1)) to add a trend line

pl <- ggplot(df,aes(x=CPI,y=HDI,color=Region))
pl <- pl + geom_point(shape=1,size=5) + geom_smooth(aes(group=1),
                                                    method = 'lm',
                                                    formula = y ~ log(x),
                                                    se=F,
                                                    color='red')
pl

#It's really starting to look similar! 
#But we still need to add labels, we can use geom_text! 
#Add geom_text(aes(label=Country)) to pl2 and see what happens. 
#(Hint: It should be way too many labels)

pl2 <- pl + geom_text(aes(label=Country))
pl2

#Labeling a subset is actually pretty tricky! 
#So we're just going to give you the answer since it 
#would require manually selecting the subset of countries we want to label!

pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

pl3 <- pl + geom_text(aes(label = Country), color = "gray20", 
                       data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)
pl3

#Almost there! 
#Still not perfect, but good enough for this assignment. 
#Later on we'll see why interactive plots are better for labeling. 
#Now let's just add some labels and a theme, set the x and y scales and we're done!

#Add theme_bw() to your plot and save this to pl4

pl4 <- pl3 + theme_bw()
pl4


#Add scale_x_continuous() and set the following arguments:

#name = Same x axis as the Economist Plot
#limits = Pass a vector of appropriate x limits
#breaks = 1:10

pl5 <- pl4 + scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",
                                limits = c(.9, 10.5),breaks=1:10) 
pl5

#Now use scale_y_continuous to do similar operations to the y axis!
  
pl6 <- pl5 + scale_y_continuous(name='Human Development Index, 2011 (1=best)',
                                limits = c(.2,1))
pl6

#Finally use ggtitle() to add a string as a title.

pl7 <- pl6 + ggtitle('Corruption and Human Development')
pl7
