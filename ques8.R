# Write R command to create the given graphs. Add legends wherever necessary.
# a) Box plot with different colors between height and weight of a student
# b) Histogram representing the frequency of height of students. 
# c) Bar Chart of age of the students showing Student ID as labels for bars. 
# d) Show a matrix of scatter plot of Height, Weight and Age of students.
# e) Show two line plots for Height vs Weight of students.Create 
# one plot for heights less than 160 and other for height greater than 160.

Student<-data.frame(StudentID=c("S1","S2","S3","S4","S5","S6","S7"),
                     Height=c(165,156,160,159,167,157,158), 
                     Weight=c(70,65,76,67,78,64,60), 
                     Age=c(26,32,45,30,29,32,29))
#-----------------------------------------------------------------------------                   
# a)
boxplot(Student$Height,col=c("green","red"),Student$Weight,notch = TRUE,
        main="Boxplot between height and weight",
        ylab="Measurement",
        names = c("Height","Weight"))
legend("topright",c("Height","Weight"),
       col=c("green","red"),pch=c(6))

#-----------------------------------------------------------------------------
# b)
hist(Student$Height,main = "Histogram of student height",
     xlab = "Height",col = "lightgreen",border = "darkgreen")

#-----------------------------------------------------------------------------
# c)
barplot(Student$Age,main = "Age of student",
        ylab = "Age",xlab = "Student ID",
        names.arg = Student$StudentID,
        col = "orange",border = "red")

#-----------------------------------------------------------------------------
# d)
pairs(~Height+Weight+Age,data=Student,
      main="Scatter plot matrix",
      col=c("red","green","blue"))

#-----------------------------------------------------------------------------
# e)
s1<-Student[Student$Height<160,]
s2<-Student[Student$Height>160,]
plot(s1$Height,s1$Weight,type="o",
     col="red",xlab = "Height",
     ylab = "Weight",
     main = "Height vs Weight",
     xlim = c(156,168),
     ylim = c(60,78))
lines(s2$Height,s2$Weight,type="o",col="green")
legend("top",legend = c("Height<160","Height>160"),
       col=c("red","green"),pch = 4)

