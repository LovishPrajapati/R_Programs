#Q7: For the employee dataset, plot the following.Add legends wherever necessary.
# a) Histogram showing number of male and female employees in the organization
# b) Histogram showing number of male and female employees in each department.
# c) Boxplot to compare the salary of male and female employees using different colours for each boxplot.

Employee<-data.frame(Names=c("Lovish","Gopal","Ujjwal","Jyoti","Vidhi","pankaj","sanket","swati") ,
                     Age=c(21,20,25,20,65,25,24,26), 
                     Gender=factor(c("Male","Male","Male","Female","Female","Male","Male","Female")), 
                     Department=factor(c("CS","RCT","Finance","HR","HR","HR","HR","Finance")), 
                     Salary=c(50000,20000,10000,40000,50000,20000,6000,45000), 
                     stringsAsFactors = FALSE)
#--------------------------------------------------------------
barplot(table(Employee$Gender),main="Gender",ylab="Number of employee")

#---------------------------------------------------------------
gen<-matrix(table(Employee$Gender,Employee$Department),nrow=2,ncol=4)
barplot(gen,beside=TRUE,names.arg=c("CS","Finance","HR","RCT"),
        col=c("red","blue"), xlab="Department",ylab="Number of employees")
legend("topright",c("FEMALE","MALE"),
       col=c("red","blue"),pch=c(6))

#---------------------------------------------------------------
maleSalary<-Employee[Employee$Gender=="Male",]$Salary
femaleSalary<-Employee[Employee$Gender=="Female",]$Salary
boxplot(maleSalary,col=c("green","red"),femaleSalary,main="Male and Female Salary",ylab="Salary")
legend("bottomright",c("MALE","FEMALE"),
       col=c("green","red"),pch=c(6))


