#  For the employee data frame created in previous question, write the queries to:
# a)	Find the maximum length of name of employee.
# b)	Find the mean salary of the employees.
# c)	Write a function to find the average salary of employee and compare it to mean, whether the two are equal or not. 
# d)	Find the median salary of the employees and compare it with the mean salary and mention which is greater.
# e)	Print the names of employees who are at least 60 years old and their salary is greater than the mean salary.
# f)	Sort the data frame with respect to the salary column.
# g)	Sort the data frame with respect to the salary and age column.
# h)	Change the “HR” deptt of employees to “RCT” deptt.
#i)	Count the number of male and female employees of each age.
#(for eg: is 24 is age of at least one employee, then how many male and female employees have age 24)

Employee<-data.frame(Names=c("Lovish","Gopal","Ujjwal","Jyoti","Vidhi") ,
                     Age=c(21,20,25,20,65), 
                     Gender=factor(c("Male","Male","Male","Female","Female")), 
                     Department=factor(c("CS","RCT","Finance","HR","HR")), 
                     Salary=c(50000,20000,10000,40000,50000), 
                     stringsAsFactors = FALSE)

# a)
cat("maximum length of name of employee: ",max(nchar(Employee$Names)))

# b)
cat("mean salary of the employees: ",mean(Employee$Salary))

# c)
avgSalary<-function(){
  avg<-(sum(Employee$Salary))/(nrow(Employee))
  meann<-mean(Employee$Salary)
  if(avg == meann)
    cat("Average and mean are equal: ", avg)
  else
    print("Not equal")
}
avgSalary()

# d)
medianSalary<-median(Employee$Salary)
if(meann>medianSalary){
  print("Mean salary is greater than median salary")
}else{
  print("Median salary is greater than mean salary")}

# e)
subset(Employee,Employee$Age>=60 & Employee$Salary>meann, select = Names )

# f)
Employee[order(Employee$Salary),]

# g) 
Employee[order(Employee$Salary, Employee$Age),]

# h) 
Employee$Department<-as.character(Employee$Department)
Employee[Employee$Department == "HR",]$Department<-"RCT"
Employee$Department<-as.factor(Employee$Department)

# i)
table(Employee$Gender,Employee$Age)

