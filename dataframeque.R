#Creating Data Frame
Employee<-data.frame(Names=c("Lovish","Gopal","Ujjwal","Jyoti","Vidhi") ,
                     Age=c(21,20,19,20,65), 
                     Gender=factor(c("Male","Male","Male","Female","Female")), 
                     Department=factor(c("CS","CS","Finance","HR","HR")), 
                     Salary=c(50000,20000,60000,40000,12000), 
                     stringsAsFactors = FALSE)

#Print the number of rows and column in the data frame
cat("Number of rows and columns:",nrow(Employee)," ",ncol(Employee))

#Print the class of each column using loop
for(i in 1:ncol(Employee)){
  print(class(Employee[[i]]))
}

#Add a new row to data frame
newRow<-c("Aditya",22,"Male","CS",45000)
Employee<-rbind(Employee,newRow)
Employee$Salary<-as.numeric(Employee$Salary)
Employee$Age<-as.numeric(Employee$Age)

#Add new column with 25% increased salary
Employee<-cbind(Employee,"New Salary" = as.numeric(Employee$Salary)*1.25 )

#Print structure of data frame
str(Employee)

#Print the employee who are above 60
Employee[Employee$Age>60,]

#Print the employee names along their department
subset(Employee, select = c(Names,Department))

#Print the number of male and female employees
cat("Male: ",nrow(Employee[Employee$Gender=='Male',]))
cat("Female: ",nrow(Employee[Employee$Gender=='Female',]))

#Print the data frame but hide the salary column
subset(Employee, select = -Salary)


